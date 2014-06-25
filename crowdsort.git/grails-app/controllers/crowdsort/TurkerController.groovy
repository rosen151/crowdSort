package crowdsort

import edu.msu.mi.gwurk.AssignmentView
import edu.msu.mi.gwurk.HitView
import edu.msu.mi.gwurk.TaskRun

class TurkerController {

    def index() {

        def task = params.task as Long
        print task
        print "^^^^ Task ID ^^^^"
        def pID = TaskRun.get(task as Long).getUserProperty("projID") as Long
        print pID
        print "^^^^ Project ID ^^^^"


        def project = Project.get(pID)
        def categories = project.categories

        //Get the pages for the project, sort it ascending by times sorted, and only grab the lowest 10
        def allPages = Page.findAllByProject(Project.get(pID), [sort: "timesSorted", order: "asc", max: 10])

        //Only add the pages that still need to be sorted to the list, if the page has been sorted the max times, exclude it
        def pages = [] as List
        allPages.each {
            if (it.timesSorted < project.timesToSort) {
                pages.add(it)
            }
        }

        [categories:categories, pages:pages, project:project, projectID: pID]
    }

    def processInfo() {

        def project = Project.get(params.projectID)
        def turker = params.workerID
        def pages = project.pages

        //if (params.containsValue('Select...')) {
        //   render(view: "index", model:[project:project])
        //}

        //Iterate through all the pages in the project, including those that were not jsut submitted
        pages.each {
            //If the submitted page is in the list of all pages for the project, save a new cardsort.
            if (params.containsKey(it.pageTitle)) {

                def cardSort = new Cardsort()
                cardSort.projectID = project.id

                cardSort.turkerID = turker

                //The category the turker sorted the page into
                cardSort.category = params.get(it.pageTitle)

                //The title of the page that was sorted
                cardSort.page = it.pageTitle

                it.timesSorted += 1

                cardSort.save(flush: true)
            }
        }

        redirect(action: "doneSorting")
    }

    def doneSorting() {

    }
}
