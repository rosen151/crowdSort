package crowdsort

class ShiroUser {
    String username
    String passwordHash

    static hasMany = [ roles: ShiroRole, permissions: String, projects: Project ]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
    }

    static mapping = {
        projects cascade: "all-delete-orphan"
        autoImport false
    }
}
