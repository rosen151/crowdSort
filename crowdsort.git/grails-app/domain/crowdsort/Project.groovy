package crowdsort

import edu.msu.mi.gwurk.HitView

class Project {

    static constraints = {
    }
    static belongsTo = [user: ShiroUser]
    String projectTitle
    Integer timesToSort
    static hasMany = [categories: Category, pages: Page]
    static mapping = {
        categories cascade: "all-delete-orphan"
        pages cascade: "all-delete-orphan"
    }

}
