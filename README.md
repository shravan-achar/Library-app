The application is hosted at https://my-library-assisstant.herokuapp.com/

Admin Credentials: Username: admin@ncsu.edu Password: admin123

Rooms can be booked using "Make Booking" and "Book Search" options present at the bottom of the screen.

Make Booking: Allows to quickly book a room by specifying the room number and time.Both options are mandatory Room Search: Search results based on parameters like room number, location, time, size can be retrieved.

All other features are self-explanatory

When an admit deletes a room all the history associated with that room is deleted. So the user history doesn't contain the data of that room anymore.

When memeber is deleted by the admin, his bookings are deleted. Other members will be able to use the slots alloted to him.


Log in/SignUp:
Upon opening the first time, use Login/Signup options available at the bottom of the screen
Admin signup is not available as only another admin can add a new admin
Library members can register themselves by using the Signup options

Booking:
When you login as a member, you will be directed to "Make a Booking" page where u can enter the date, time and room number.
If a slot is available for the requested time, you will be asked to add organizer's mail id (only for admin mode) and the participants email IDs (admin and member mode)
If no slots are available, then you will be displayed an error message suggesting to use "Room Search" instead
If you (member) already have a booking, then u will not be able to create a new booking until the previously booked slot ends or you cancel the booking
Reservations can only be made one week in advance.

Room Search:
Enter the room, room size or start date-time, to get a list of available options available.
Choose the slot which you want to book by selecting "Book"
You will be asked to add organizer's mail id (only for admin mode) and the participants email IDs (admin and member mode)


Edit Profile:
After logging in, Edit Profile will be available at the bottom of the screen
Allows user to change name, email, password.
In case of library member, it allows him/her to view booking history.

Admin Menu:
When logged in admin mode, you will be directed to Admin menu which has options like "Add/Remove a Room", "View Rooms", "Add/Remove Admin", etc
All the options are self explanatory
To remove or view a member's booking history, use "View All Bookings".
Room List can also be viewed from "Rooms List" link provided at the bottom
"View Rooms" allows to view the schedule of a room and delete the room if required.

Extra Credit:
When a user adds other members in the reservation, a notification will be sent to all attendees except the user himself. The notification will appear when an attendee logs in.
Admin can make multiple reservations for a library member. This can be checked by booking two or more rooms for a member, while logged in as an admin.

Round 2 commits have been made in and around the initial submission phase. Updated the README file for round 2.
