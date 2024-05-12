module UsersHelper
def isActive
    if !@user.soft_delete
        user
    end
end
end