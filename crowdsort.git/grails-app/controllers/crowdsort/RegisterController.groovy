package crowdsort

import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils


class RegisterController {

    def shiroSecurityService

    def index() {
        //Create a new user
        def user = new ShiroUser()
        [user: user]
    }

    def register(){
        //Begin reigster process by finding the desired username
        def user = ShiroUser.findByUsername(params.username)
        //Vreify the username is unique
        if (user) {
            flash.message = "User already exists with the username ${params.username}"
            render (view: 'index')

        }
        else {
            //Verify the passwords entered match
            if (params.password != params.password2) {
                flash.message = "Passwords do not match!"
                render (view: 'index')
            }
            //If everything checks out, create the new user
            else {
                user = new ShiroUser(
                        username: params.username, passwordHash: shiroSecurityService.encodePassword(params.password)
                )

                if (user.save(flush: true)) {
                    //Add the user role to the user
                    user.addToRoles(ShiroRole.findByName('ROLE_USER'))
                    //Create a new authorization token to store the session
                    def authToken = new UsernamePasswordToken(params.username, params.password)
                    SecurityUtils.subject.login(authToken)
                    redirect(controller: 'project', action: 'secured')
                }
                else {
                        flash.message = "Something went wrong"
                        render(view: 'index')
                }


            }
        }
    }
}
