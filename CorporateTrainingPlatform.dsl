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
        ci = person "Content Creators/Instructors"
        it = person "IT Support Staff "
        
        
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
        
        /* Relationships */
        le -> ctp.wa "Uses for training"
        cc -> ctp.wa "Manages learners"
        pa -> ctp.wa "Administers the platform"
        ci -> ctp.wa "Publishes training content"
        it -> ctp.wa "Provides support"
        
        ctp.wa -> ctp.db "Reads/writes data"
        ctp.wa -> ctp.bApi "Makes API calls"
        ctp.bApi -> ctp.ana "Sends usage data"
    }

    views {
        systemContext ctp "TrainingPlatformContext" {
            include *
            autolayout lr
        }

        container ctp "TrainingPlatformContainers" {
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
    configuration {
        scope softwaresystem
    }
}
