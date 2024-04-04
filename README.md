# Group-10_Project1
Tennis Club Database

Problem Description

As the hires of this esteemed tennis club, providing players of all skill levels with an outstanding tennis experience is our primary goal. A vibrant membership program, designed for individuals and families who are passionate about the same sport, is the foundation of the club's philosophy. In order to maintain members' satisfaction and ongoing involvement, we place a high priority on learning about their requirements, preferences, and feedback. The committed staff oversees every facet of club operations, including event planning, coaching sessions, league activities, and facility upkeep. Modern amenities and state-of-the-art tennis courts are what the tennis club takes great pride in providing; they provide the ideal setting for competitive events, matches, and practice sessions. We also offer a wide range of equipment that is necessary for games and training, so our members have all they require to succeed on the court. We create a lively community environment by offering a varied schedule of events, such as league games and tournaments, which promotes member camaraderie and skill improvement. We are dedicated to developing talent and assisting players of all ages and abilities in realizing their full potential within our tennis club community. Qualified instructors conduct customized coaching sessions.

Data Model Explanation

As a part of the Terrific Tennis Team company, our establishment caters to a diverse community of tennis enthusiasts spanning all ages and skill levels. We offer a comprehensive array of programs and services provided by our staff (through vendors of our Pro Shop and coaching lessons taught by our expert coaches) to members (who can select memberships, utilize rentals, and participate in tournaments). With a multitude of amenities at our disposal, including top-notch tennis courts, a fully-stocked pro shop, and expert coaching services, we strive to provide an immersive and fulfilling tennis experience for all who enter our doors and play on our courts.
Our database model encompasses several crucial entities essential for the seamless operation of our club. Firstly, our "Lessons" entity captures vital information such as lesson IDs, program names, types, schedules, and assigned coaches. This facilitates the organization and scheduling of instructional sessions tailored to the unique requirements of our members. Concurrently, our "Reservations" entity tracks reservations made by members for court usage, ensuring efficient court allocation through timely reservations. Moreover, our club offers equipment rental services, managed through the "EquipmentRentals" entity, enabling members to access high-quality tennis gear as needed. Additionally, we host tournaments regularly, documented within the "Tournaments" entity, providing opportunities for friendly competition and skill enhancement among our members. Our coaching services, administered by dedicated professionals, are documented through the "Coach" and "CoachingSession" entities, facilitating effective management and scheduling of coaching sessions. Furthermore, our database captures member information via the "Members" entity, including membership details, participation in lessons and tournaments, and transaction history. This enables personalized service delivery and member engagement initiatives. The "ProShopItem" and "Vendor" entities track inventory and supplier information, ensuring a well-stocked pro shop offering quality merchandise sourced from reliable vendors.
Overall, our database model serves as the cornerstone of our club's operations, enabling streamlined management of lessons, reservations, equipment rentals, tournaments, coaching services, member interactions, and pro shop inventory. Through the effective utilization of these entities and their relationships, we uphold our commitment to delivering exceptional tennis experiences and fostering a tennis community with organized, efficient, and tracking systems.

![Group Project 1 Model](https://github.com/zrb33664/Group-10_Project1/assets/163185204/7b2e67b7-df99-4537-b950-f1d2c32cb8c5)

Queries

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

![Screenshot 2024-04-04 155513](https://github.com/zrb33664/Group-10_Project1/assets/150175934/e118d624-3dd9-41fb-830d-219d3faa14af)


#2. By executing this query, the club manager obtains a list of members along with their maximum transaction amounts. This information allows the manager to identify members who are willing to make significant purchases during a single visit to the club. Understanding members' spending behaviors empowers the manager to tailor marketing strategies, promotions, and services to cater to high-spending members, potentially fostering increased revenue generation for the club. Moreover, recognizing and acknowledging members who contribute significantly to the club's financial success can enhance member satisfaction and loyalty. Overall, this query aids managers in making informed decisions regarding member engagement and revenue optimization within the club.

SELECT
memberID,
memberFirstName,
memberLastName,
(SELECT MAX(amount)
FROM Transaction
WHERE Members_memberID=M.memberID)
AS MaxTransactionAmount
FROM Members M;

![Screenshot 2024-04-04 155749](https://github.com/zrb33664/Group-10_Project1/assets/150175934/a14b86ba-7362-4ca3-8e6e-f63943b47f79)


#3. Within this query, the club manager obtains a list of active vendors who have supplied products for recent transactions within the last year. This information enables the manager to assess the reliability and consistency of vendors in supplying products to the club. Additionally, it facilitates communication and collaboration with vendors to ensure smooth procurement processes and maintain inventory levels. 

SELECT
DISTINCT V.vendorID,
V.vendorName,
V.contactPerson,
V.vendorEmail,
V.phoneNumber
FROM Vendor AS V
JOIN ProShopItem AS P ON V.vendorID = P.Vendor_vendorID
JOIN Receipt AS R ON P.productID = R.ProShopItem_productID
JOIN Purchase AS PU ON R.Purchase_purchaseID = PU.purchaseID
WHERE PU.purchaseDate > 2024-01-01;

![Screenshot 2024-04-04 155610](https://github.com/zrb33664/Group-10_Project1/assets/150175934/d35b30b9-7655-49c9-8aae-0373bd5f12b3)


#4. This SQL query is designed to track tournament participation among club members and calculate the total amount they have paid in registration fees. By retrieving this information, club managers can gain insights into members who participate in high-paying tournaments, enabling them to encourage continued participation and engagement in future events.the club manager obtains a list of club members along with the total amount they have paid in tournament registration fees. This information enables the manager to identify members who are actively participating in tournaments and contributing significant revenue to the club through registration fees. Armed with this insight, the manager can tailor incentives, promotions, or rewards to encourage continued participation and foster member engagement. Additionally, understanding the participation patterns of members allows the manager to plan future tournaments and allocate resources effectively to maximize member satisfaction and club revenue.

SELECT DISTINCT memberFirstName, memberLastName, SUM(Participation.registrationFee)
FROM Members
JOIN Participation ON Members.memberID=Participation.Members_memberID
JOIN Tournaments ON Participation.Tournaments_eventID=Tournaments.eventID
GROUP BY memberFirstName, memberLastName;

#5. In this query, the club manager obtains a list of club members along with the total number of coaching sessions attended by each member. This information provides valuable insights into the popularity of coaching programs among members, allowing the manager to identify members who actively participate in coaching sessions and those who may require additional encouragement or support to participate. Furthermore, understanding member enrollment in coaching sessions enables the manager to assess the effectiveness of coaching programs, identify trends, and make data-driven decisions to enhance the overall coaching experience for members. 

SELECT Members_memberID,
COUNT(*) AS TotalSessions
FROM CoachingSession
GROUP BY Members_memberID
ORDER BY TotalSessions DESC;

#6. This SQL query is crafted to retrieve information about coaches who conduct more than 5 coaching sessions. By executing this query, club managers can gain insights into the popularity and effectiveness of individual coaches, allowing them to assess their performance and make informed decisions regarding coaching allocations and recognition. This information provides valuable insights into the workload and effectiveness of individual coaches, allowing the manager to identify coaches who are favored by club members and demonstrate initiative in conducting coaching sessions. Additionally, recognizing coaches who conduct a high volume of coaching sessions can serve as a form of encouragement and acknowledgment for their dedication and contribution to the club. Furthermore, this query enables the manager to make data-driven decisions regarding coaching allocations, scheduling, and performance evaluation to optimize the coaching experience for club members. 

SELECT Coach_coachID, COUNT(*) AS TotalSessions
FROM CoachingSession
GROUP BY Coach_coachID
HAVING TotalSessions > 5;

#7. This SQL query retrieves data from the ProShopItem table, specifically selecting the productID, productName, category, and productPrice columns. The ORDER BY clause is utilized to sort the result set in descending order based on the productPrice column, ensuring that the most expensive items appear at the top of the list. This information aids managers in understanding the pricing structure of the pro shop and allows them to make informed decisions regarding inventory management, pricing adjustments, and marketing strategies. Additionally, recognizing the most expensive items can help managers highlight premium offerings to customers and potentially increase revenue by promoting high-value products. 

SELECT productID, productName, category, productPrice
FROM ProShopItem
ORDER BY productPrice DESC;

#8. By executing this query, the club manager obtains a list of top-selling items in the pro shop, along with the total quantity sold for each item. This information helps the manager understand the popularity of different products among customers and enables informed decisions regarding inventory management, stock replenishment, and marketing strategies. Additionally, identifying top-selling items allows the manager to prioritize these items in promotions and displays, potentially increasing sales and revenue. Overall, this query serves as a valuable tool for optimizing inventory management and enhancing profitability in the pro shop.

SELECT PSI.productID, PSI.productName, PSI.category,
SUM(P.qtyPurchased) AS TotalQuantitySold
FROM ProShopItem AS PSI
JOIN Receipt AS R ON PSI.productID = R.ProShopItem_productID
JOIN Purchase AS P ON R.Purchase_purchaseID=P.purchaseID
GROUP BY PSI.productID, PSI.productName, PSI.category
ORDER BY TotalQuantitySold DESC;





![Group Project 1 Matrix](https://github.com/zrb33664/Group-10_Project1/assets/163185204/128ce132-6c4b-49d7-b8d5-3f80b0a2885b)

