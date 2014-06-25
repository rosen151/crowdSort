package crowdsort

class Page {

    static constraints = {
    }
    static belongsTo = [project: Project]
    String pageTitle
    Integer timesSorted

}
