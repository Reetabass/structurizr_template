workspace "Corporate Training Platform" "Context diagram for the Corporate Training Platform." {

    !identifiers hierarchical

    model {

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


        /* Users */

        le = person "Learners" 
        cc = person "Corporate Clients (HR Managers/Training Coordinators)"
        pa = person "Platform Administrators"
        ci = person "Content Creators/Instructors"
        it = person "IT Support Staff "

        /* System */

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

        /* External Systems */

        hrs = softwareSystem "HR System" {
            tags "ExternalEntity"
        }
        vs = softwareSystem "Video Streaming Service / CDN" {
            tags "ExternalEntity"
        }
        idp = softwareSystem "Authentication Provider (SSO / Identity Provider)" {
            tags "ExternalEntity"
        }
        pay = softwareSystem "Payment Gateway" {
            tags "ExternalEntity"
        }
        mail = softwareSystem "Email / Notification Service" {
            tags "ExternalEntity"
        }
               
     
        /* System Context Relationships */
        le -> ctp "Uses the platform to complete training and receive certificates"
        cc -> ctp "Use dashboards, assign training, integrate data with HR systems"
        pa -> ctp "Maintain system, manage accounts, monitor usage."
        ci -> ctp "Uploads/manages training content, reviews feedback and analytics"
        it -> ctp "Provides support and troubleshooting, and ensure uptime."
        
        /* External System Relationships*/
        ctp -> hrs "Synchronises training and employee data"
        ctp -> vs "Streams training videos"
        ctp -> idp "Uses for secure login"
        ctp -> pay "Handles billing and subscriptions"
        ctp -> mail "Sends notifications, reminders, and certificates"

        /* Container Relationships */        
        # ctp.wa -> ctp.db "Reads/writes data"
        # ctp.wa -> ctp.bApi "Makes API calls"
        # ctp.bApi -> ctp.ana "Sends usage data"
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
