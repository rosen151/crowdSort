package crowdsort

import com.amazonaws.mturk.service.axis.RequesterService
import edu.msu.mi.gwurk.Credentials
import edu.msu.mi.gwurk.GwurkEvent
import edu.msu.mi.gwurk.HitView
import edu.msu.mi.gwurk.MturkAwsFacadeService
import edu.msu.mi.gwurk.SingleHitTask
import edu.msu.mi.gwurk.Task
import edu.msu.mi.gwurk.TaskProperties
import edu.msu.mi.gwurk.TaskRun
import edu.msu.mi.gwurk.Workflow
import org.apache.shiro.SecurityUtils
import org.apache.shiro.session.Session
import org.codehaus.groovy.grails.scaffolding.DomainClassPropertyComparator

import javax.security.auth.Subject

class ProjectController {

    def mturkTaskService
    def mturkMonitorService
    def mturkAwsFacadeService

    def index() {
        def currentUser = SecurityUtils.subject
        //Find the current logged in user and all projects owned by that user
        if(currentUser.hasRole("ROLE_USER") || currentUser.hasRole("admin")) {
            def username = SecurityUtils.subject.principal as String
            print username
            def projects = ShiroUser.findByUsername(username)
            [projects: projects, username: username]
        }


        else {
            print "something went wrong"
        }


    }


    def secured() {
        render "This page is secured"
    }

    def admin() {
        render "This page requires admin access"
    }

    def addCategories() {
        def project = Project.get(params.projectID)

        [projectID: params.projectID, categories: project.categories]
    }

    def addCategory(){

        def pID = params.projectID as Long
        def project = Project.get(pID)

        //Test to see if the submitted category is already in the list, and "flag" it.
        def flag = false
        for (category in project.categories) {
            if (category.category == params.category) {
                flag = true
            }
        }
        //Add to the list if the category is not blank and is new
        if (params.pageTitle != '' && !flag) {
            print params.category
            project.addToCategories(category: params.category)
            project.save()
        }

        redirect(action: "addCategories", params: [projectID: pID])
    }

    def removeCategory(){
        def pID = params.projectID as Long
        def project = Project.get(pID)
        //Check to make sure that something was selected to delete
        if ((params.categoryDelete == null).or(params.categoryDelete == "")) {
            redirect(action: "addCategories", params: [projectID: pID])
        }


        //Check to see if only one item was selected to delete, in that case it is a String
        else if (params.categoryDelete.class == String) {
           def toDelete = params.categoryDelete as Long
            project.removeFromCategories(Category.get(toDelete))
            project.save()
            redirect(action: "addCategories", params: [projectID: pID])
        }
        //Check to see if multiple items were selected to delete, in that case it is a List
        else {
            params.categoryDelete.each {
                if (it in project.categories) {
                    project.removeFromCategories(category: it)
                }
            }
            project.save()
            redirect(action: "addCategories", params: [projectID: pID])
        }
    }

    def removePage(){
        def pID = params.projectID as Long
        def project = Project.get(pID)
        //Check to make sure that something was selected to delete
        if ((params.pageDelete == null).or(params.pageDelete == "")) {
            redirect(action: "addPages", params: [projectID: pID])
        }


        //Check to see if only one item was selected to delete, in that case it is a String
        else if (params.pageDelete.class == String) {
            def toDelete = params.pageDelete as Long
            project.removeFromPages(Page.get(toDelete))
            project.save()
            redirect(action: "addPages", params: [projectID: pID])
        }
        //Check to see if multiple items were selected to delete, in that case it is a List
        else {
            params.pageDelete.each {
                if (it in project.pages) {
                    project.removeFromPages(pageTitle: it)
                }
            }
            project.save()
            redirect(action: "addPages", params: [projectID: pID])
        }
    }

    def startProject(){
        //Set the project properties: User, time to sort, the project and ID
        def currentUser = SecurityUtils.subject.principal as String
        def sortTimes = params.timesToSort as Integer
        def project =  ShiroUser.findByUsername(currentUser).addToProjects(projectTitle: params.projectTitle, timesToSort: sortTimes )
        project.save(flush: true)
        def projectID = Project.findByUserAndProjectTitle(ShiroUser.get(project.id), params.projectTitle).id
        redirect (action: 'addCategories', params: [projectID: projectID] )
    }

    def newProject() {

    }

    def viewProjects(){

        //Get the list of projects that belong to the logged in user
        def currentUser = SecurityUtils.subject.principal as String
        def projects = ShiroUser.findByUsername(currentUser)
        [projects: projects]


    }

    def viewAll(){
        //Get every project to view
        def projects = Project.getAll()
        [projects: projects]
    }


    def logout(){
        //Logout the user
        def currentUser = SecurityUtils.subject
        currentUser.logout()
        redirect(controller: 'auth', action: 'login')
    }

    def deleteProject(){

        //Get the project to delete
        def project = Project.get(params.id)
        def pID = project.id as String

       // def userProp = TaskRun.getUserProperty()

        //Delete the project
        project.delete()
        redirect(action:'index')
    }

    def addPages(){

        //Get and return the porject to add pages to
        def project = Project.get(params.projectID)

       [projectID: params.projectID, pages: project.pages]
    }

    def updatePages(){
        def pID = params.projectID as Long
        def project = Project.get(pID)

        //Test to see if the submitted page is already in the list, and "flag" it
        def flag = false
        for (page in project.pages) {
            if (page.pageTitle == params.pageTitle) {
                flag = true
            }
        }

        //Add to the list if the page is not blank and is new
        if (params.pageTitle != '' && !flag) {
            print params.pageTitle
            project.addToPages(pageTitle: params.pageTitle, timesSorted: 0)
            project.save()
        }

        redirect(action: "addPages", params: [projectID: pID])
    }

    def makeHIT(){


        def pID = params.projectID as Long
        def project = Project.get(pID)
        def x = 0 as Double
        def numPages = project.pages.size()
        print numPages
        def timesToSort = project.timesToSort

        //Times to sort is calculate in the following manner:
        //Each Turker sorts a maximum of 10 pages at a time. Can sort less, for example, 3
        //If there are less than 10 pages: Set the times to sort equal to what the user requested
        //If there are more than 10 pages:
            //Example: User enters 12 pages and wants 3 sorts.
            //There are a total of 36 (12 * 3) individual sorts to be completed (each Turker does a max of 10)
            //Divide the total individual sorts by the requested by 10 (the max a Turker can sort at once)
            //Any remainder (e.g. 6 pages) needs to be rounded up to one total sort.
            //The the example provided, because the user wants all pages sorted 3 times, it requires 4 turkers
            //One turker will sort only 6 pages, and other three sort 10, for a total of 36 page sorts
        if (numPages >= 10) {
            x =  ((numPages * timesToSort)/10) as Double
            def y = x.mod(1)
            x = x.round()
            if (y < 0.5) {
                x+=1
            }
        }
        else {
            x = timesToSort
        }




        //Set the name of the hit to the project name
        def nameHIT = project.projectTitle

       /* def t = new SingleHitTask(nameHIT,
                [maxAssignments:x]
        ).save(flush: true)

*/


        int iterations = 1
        def props = TaskProperties.findByTitle(nameHIT)
        //mturkMonitorService.launch(Workflow.findByName("Crowdsort"),false,iterations,Credentials.findByName("aws"), props as Map)
        mturkMonitorService.launch(Workflow.findByName("Crowdsort"),false,iterations,Credentials.findByName("aws"), ["New Task":["maxAssignments":x,"title":project.projectTitle]])



        def runTask = TaskRun.get(project.id)
        print project.id
        print '^^^^^^^^^ BLAH BLAH BLAH ^^^^^^^^^^^^'
        runTask.setUserProperty("projID", project.id as String )

        redirect(action: "index", params: [projectID: pID])
    }

    def users(){
        //Get all the users to be displayed
        def users = ShiroUser.getAll()
        [users: users]
    }

    def deleteUser(){
        //Delete a particular user by their ID
        def toDelete = params.id as Long
        print toDelete
        def user = ShiroUser.get(toDelete)
        user.delete()
        redirect(action: 'users')
    }

    def viewProjectStatus(){

        //get the project ID to show the status of
        def pID = params.id as Long
        def project = Project.get(pID)

        def cardsort =  project.cardsort

        [project: project, cardsort: cardsort]

    }
}
