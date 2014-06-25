import crowdsort.Cardsort
import crowdsort.Project
import crowdsort.ShiroRole
import crowdsort.ShiroUser
import edu.msu.mi.gwurk.Credentials
import edu.msu.mi.gwurk.Workflow
import edu.msu.mi.gwurk.AssignmentView
import edu.msu.mi.gwurk.GwurkEvent
import edu.msu.mi.gwurk.HitView
import edu.msu.mi.gwurk.SingleHitTask
import edu.msu.mi.gwurk.Task
import edu.msu.mi.gwurk.TaskRun
import edu.msu.mi.gwurk.WorkflowRun




class BootStrap {

    def shiroSecurityService
    def mturkTaskService
    def init = { servletContext ->

        def role = new ShiroRole(
                name: 'ROLE_USER'
        )
        role.save(flush: true)

       def adminRole = new ShiroRole(
               name: 'admin'
       )
        adminRole.save(flush: true)
        def user = new ShiroUser(
                username: "test", passwordHash: shiroSecurityService.encodePassword("password")
        )
        user.addToRoles(role)

        user.save(flush: true)

        def adminUser = new ShiroUser(
                username: "admin", passwordHash: shiroSecurityService.encodePassword("admin")
        )
        adminUser.addToRoles(adminRole)

        adminUser.save(flush: true)



        def cred = new Credentials(
                awsId: "AKIAJMXCRPCRAG4FLWEA",
                awsSecret:"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",
                name: "aws"
        )

        cred.save()

        Workflow w = new Workflow("Crowdsort", "Cardsorting of a website", [
                rewardAmount: 0.05f,
                relaunchInterval: 1000 * 60 * 60,
                autoApprove: true,
                lifetime: 60 * 60 * 10,
                assignmentDuration: 300,
                keywords: "sorting, website, card",
                maxAssignments: 3,
                height: 1000,
                requireApproval: true
        ])

        Task one = new SingleHitTask("New Task", [
                controller: "turker",
                action: "index",
                title: "Sort a Website",
                description: "Sort web page content into the top-level categories to which they belong.",
        ]).save()

        one.save()
        w.initStartingTasks(one)
        w.save(flush: true)
        mturkTaskService.installTask(one) { type, GwurkEvent evt ->
            switch (type) {

                case GwurkEvent.Type.HIT_COMPLETE:
                    log.info("Hit complete!")
                    break
                case GwurkEvent.Type.ASSIGNMENT_COMPLETE:
                    log.info("Assignment complete!")
                    def assignment = evt.assignmentView.answer
                    print assignment.projectID
                    print '^^^^^^^^^^^^^^^^^ THIS IS THE ID WE NEED!!!!!!!!! ^^^^^^^^^^^^^^^^^'
                    print '^^^^^^^^^^^^^^^^^ THIS IS THE ID WE NEED!!!!!!!!! ^^^^^^^^^^^^^^^^^'
                    print '^^^^^^^^^^^^^^^^^ THIS IS THE ID WE NEED!!!!!!!!! ^^^^^^^^^^^^^^^^^'
                    print '^^^^^^^^^^^^^^^^^ THIS IS THE ID WE NEED!!!!!!!!! ^^^^^^^^^^^^^^^^^'
                    def project = Project.get(assignment.projectID as Long)
                    def turker = assignment.workerId
                    print turker
                    print '^^^^^^^^^^ TUKER SHIT ^^^^^^^^^^^'
                    def pages = project.pages

                    //if (params.containsValue('Select...')) {
                    //   render(view: "index", model:[project:project])
                    //}

                    pages.each {
                        if (assignment.containsKey(it.pageTitle)) {

                            def cardSort = new Cardsort()
                            cardSort.projectID = project.id

                            cardSort.turkerID = turker

                            cardSort.category = assignment.get(it.pageTitle)

                            cardSort.page = it.pageTitle

                            it.timesSorted += 1

                            cardSort.save(flush: true)
                        }
                    }


                    break
                case GwurkEvent.Type.TASK_COMPLETE:
                    log.info("Task complete!")
                    break
            }

        }




        mturkTaskService.installWorkflow(w) { a,b->
            log.info("Workflow complete!")
        }



    }
    def destroy = {
    }
}
