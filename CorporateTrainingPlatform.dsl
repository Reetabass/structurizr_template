workspace "Name" "Description" {

    !identifiers hierarchical

    model {

         /* 
         * USERS
         *
         *
         *
         */

        archetypes {
            WebApplication = container {
                tags "Web"
            }
            MobileApp = container {
                tags "Mobile"
            }
            Database = container {
                tags "Database"
            }
            BackendAPI = container {
                tags "Backend"
            }
            NotificationService = container {

            }
            Analytics = container {

            }


        } 


        /* 
         * USERS
         *
         *
         *
         */

        le = person "Learners"
        cc = person "Corporate Clients (HR Managers/Training Coordinators)"
        pa = person "Platform Administrators"
        C&I = person "Content Creators/Instructors"
        IT = person "IT Support Staff "
        
        
        ctp = softwareSystem "Corporate Training Platform" {
            
            wa = WebApplication "Web Application"
            db = Database "Database Schema" 
            bApi = BackendAPI "Backend API" {
                registercomp = component "Registration" "Handles participant/vendor sign-ups"
                resetpwcomp = component "Reset Password" "Allows users to reset their password with a single-use URL"
                racecomp = component "Race Management" "Manages routes, schedules, staggered starts"
                volcomp = component "Volunteer Management" "Assigns tasks, tracks volunteer status"
                trackingcomp = component "Tracking" "Real-time runner location & ETA"
                notifcomp = component "Notification" "Triggers push/email notifications"
                resultscomp = component "Results" "Records and publishes race results"
                feedbackcomp = component "Feedback" "Collects participant & volunteer feedback"
            }
            ns = NotificationService "Notification Service"
            ana = Analytics "Analytics"
            
        }

        ns = softwareSystem "Notification System" {
            tags "ExternalEntity"
        }
        

        /* 
         * PUT USE CASES HERE
         *
         * CHANGES HERE NEED TO BE MADE
         *
         */
        
        up -> ss "Registers and recieves and shares updates from"
        uv -> ss "Recieves tasks, training material and communication updates"
        urd -> ss "Notifies participants"
        us -> ss "Access race information and track participants"
        uvend -> ss "Register, select location, access participant data"
        uvc -> ss "Manages volunteers and tasks, training and updates"
        ss -> ns "Sends notifications using"
        ns -> up "Sends notifications to"
        
        
        up -> ss.wa "Visits sydmarathon.com using"
        ss.wa -> ss.spa "Delivers to the user's web browser"
        up -> ss.ma "Registers and receives and shares updates from"
        ss.bApi -> ss.db "Reads from and writes to"
        ss.spa -> ss.bApi "Makes API calls to"
        ss.ma -> ss.bApi "Makes API calls to"
        ss.bApi -> ns "Sends notifications using"
        ss.ana -> ss.ma "Displays analytics on"
        ss.ana -> ss.wa "Displays analytics on"

        ss.spa -> ss.bApi.registercomp "User registers an account"
    }

    views {
        systemContext ss "Diagram1" {
            include *
            autolayout lr
        }

        container ss "Diagram2" {
            include *
            autolayout lr
        }

        component ss.bApi "Diagram3" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #0773af
                stroke #0773af
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            element "ExternalEntity" {
                color #808080
                stroke #808080
                strokeWidth 5
                shape box
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }
}
