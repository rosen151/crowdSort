package crowdsort

import org.apache.shiro.SecurityUtils

class DashboardController {

    def index() {

       // def projects = Project.getAll()
       //  [projects:projects]
    }

    def projList() {


        //Find the current user
        def currentUser = SecurityUtils.subject

        //Retrieve all project belonging to the logged in user, if admin show all projects
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

    def viewAccount(){

        //Get the current user to show
        def currentUser = SecurityUtils.subject.principal

        [username: currentUser]
    }

    def projDash() {

        //Retrieve the project, categories and pages
        def project = Project.get(params.id)
        def categories = project.categories
        def pages = project.pages

        //Create a new map that will store sort data for each page
        def myMap = [:] as Map

        //Iterate through every page in the project
        for (page in pages) {
            //Find the number of times the page has been sorted total
            def totalSort = Cardsort.findAllByPageAndProjectID(page.pageTitle as String,project.id as Integer)
            def totalSorts = totalSort.size()

                //Iterate through the categories in the project, that is, every possible category the page could have been sorted
                for (category in categories) {

                    //Find all instances of when the page was sorted into the category
                    def countResult = Cardsort.findAllByPageAndCategoryAndProjectID(page.pageTitle as String,category.category as String,project.id as Integer)
                    def total = countResult.size() as Integer
                    //Find the percent by dividing how many times the page was sorted into the category by the total times the page was sorted across all categories.
                    def percent = 0
                    if (totalSorts != 0) {
                        percent = total/(totalSorts as Integer)
                    }

                    //Begin to store this information in a nested map, the map works this way: [page:[category1:timesSortedIntoCategory1,category2:timesSortedIntoCategory2]]
                    //The if tests to see if the page is already in the map, if it is, add the category to it
                    if (myMap.containsKey(page.pageTitle)) {
                        myMap.get(page.pageTitle) << [(category.category as String):percent]
                    }
                    //Else, create the page key and store the first category information
                    else {
                        myMap.put(page.pageTitle, [(category.category as String):percent])
                    }
                }
            }

        [myMap:myMap, project:project]
    }

    def turkResults() {
        //Get the projectID
        def project = Project.get(params.id)
        //Find all Turkers that sorted for the project
        def turkers = Cardsort.findAllByProjectID(project.id as Integer)
        //Create an empty list
        def turkList = [] as List

        for (turker in turkers) {
            //Only insert each Turker into the list once
            if (!turkList.contains(turker.turkerID)) {
                turkList.add(turker.turkerID)
            }
        }
        [project:project,turkList:turkList]
    }

    def turkShow() {
        def project = Project.get(params.projectID)
        def turkerID = params.turkerID as String

        //If a turker's particular results for a project sort
        def turkResults = Cardsort.findAllByProjectIDAndTurkerID(project.id as Integer,turkerID as String)

        [project:project,turkerID:turkerID,turkResults:turkResults]
    }
}
