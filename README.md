# Group-10_Project1
Tennis Club Database

Problem Description

As the hires of this esteemed tennis club, providing players of all skill levels with an outstanding tennis experience is our primary goal. A vibrant membership program, designed for individuals and families who are passionate about the same sport, is the foundation of the club's philosophy. In order to maintain members' satisfaction and ongoing involvement, we place a high priority on learning about their requirements, preferences, and feedback. The committed staff oversees every facet of club operations, including event planning, coaching sessions, league activities, and facility upkeep. Modern amenities and state-of-the-art tennis courts are what the tennis club takes great pride in providing; they provide the ideal setting for competitive events, matches, and practice sessions. We also offer a wide range of equipment that is necessary for games and training, so our members have all they require to succeed on the court. We create a lively community environment by offering a varied schedule of events, such as league games and tournaments, which promotes member camaraderie and skill improvement. We are dedicated to developing talent and assisting players of all ages and abilities in realizing their full potential within our tennis club community. Qualified instructors conduct customized coaching sessions.

Data Model Explanation

As a part of the Terrific Tennis Team company, our establishment caters to a diverse community of tennis enthusiasts spanning all ages and skill levels. We offer a comprehensive array of programs and services provided by our staff (through vendors of our Pro Shop and coaching lessons taught by our expert coaches) to members (who can select memberships, utilize rentals, and participate in tournaments). With a multitude of amenities at our disposal, including top-notch tennis courts, a fully-stocked pro shop, and expert coaching services, we strive to provide an immersive and fulfilling tennis experience for all who enter our doors and play on our courts.
Our database model encompasses several crucial entities essential for the seamless operation of our club. Firstly, our "Lessons" entity captures vital information such as lesson IDs, program names, types, schedules, and assigned coaches. This facilitates the organization and scheduling of instructional sessions tailored to the unique requirements of our members. Concurrently, our "Reservations" entity tracks reservations made by members for court usage, ensuring efficient court allocation through timely reservations. Moreover, our club offers equipment rental services, managed through the "EquipmentRentals" entity, enabling members to access high-quality tennis gear as needed. Additionally, we host tournaments regularly, documented within the "Tournaments" entity, providing opportunities for friendly competition and skill enhancement among our members. Our coaching services, administered by dedicated professionals, are documented through the "Coach" and "CoachingSession" entities, facilitating effective management and scheduling of coaching sessions. Furthermore, our database captures member information via the "Members" entity, including membership details, participation in lessons and tournaments, and transaction history. This enables personalized service delivery and member engagement initiatives. The "ProShopItem" and "Vendor" entities track inventory and supplier information, ensuring a well-stocked pro shop offering quality merchandise sourced from reliable vendors.
Overall, our database model serves as the cornerstone of our club's operations, enabling streamlined management of lessons, reservations, equipment rentals, tournaments, coaching services, member interactions, and pro shop inventory. Through the effective utilization of these entities and their relationships, we uphold our commitment to delivering exceptional tennis experiences and fostering a tennis community with organized, efficient, and tracking systems.

![Group Project 1 Model](https://github.com/zrb33664/Group-10_Project1/assets/163185204/7b2e67b7-df99-4537-b950-f1d2c32cb8c5)


Queries:

#1. This query is designed to retrieve details of members whose memberships have expired. It serves as a valuable tool for club managers to efficiently identify members whose memberships require renewal or termination. By executing this query, the club manager can promptly obtain a list of members with an expired membership. This information enables the manager to take necessary actions, such as sending renewal reminders to members or processing membership terminations as per the club’s policies. Additionally, having insight into expired memberships aids budgeting and resource allocation on club revenue and membership statistics. 
SELECT 
    m.memberID,
    m.memberFirstName,
    m.memberLastName,
    m.membershipType,
    m.joinDate,
    m.expirationDate
FROM Members AS m
WHERE m.expirationDate < CURDATE();
