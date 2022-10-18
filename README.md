# SEPT-Project

This is the repository for Group 6 (Thursday 4:30 class) for Software Engineering Process and Tools

## Members
* s3774430 - Myeonghoon Sun
* s3706239 - Cal Lamshed
* s3888349 - Max Foord
* s3896004 - Lachlan Van Der Klift
* s3759362 - Yongjie Shi

## Records
* Github repository :https://github.com/LightZipper/SEPT-Project/tree/Develop* jira Board : https://hoonz.atlassian.net/jira/software/projects/SEPT/boards/1## Code documentation - Release 1.0.0 - date
* Profile
* Appointments
* Login/Register
* Symptoms
* Livechat

To run the application locally :
1) cd into each and every microservice (SEPT_Backend, Profile, Appointment_Server, symptoms,chat) and run :
2) navigate to src/main/java/ and run relevent application file.
4) create sept_db database in mysql
3) cd into Frontend/lib and run main.dart

Navigate to Backend folder:
    Type in console: docker–compose up 

Creating a User:
    Follow the prompts to create a Patient user and login.
        - Doctor must have created appointment slots for Patient to select
        - Patient can add symptoms
    Doctor user added by admin, then doctor can log in using doctor login.
    Admin must be created Manually in the server, then admin can log in using admin login.

Database query
        - Doctors are stored in the doctor table of the database.
        - Patients are stored in the patient table database.
        - Symptoms are stored in the symptoms database.
