

USE al_Group_21479_G10;



#1, Query to find members with expired memberships and their personal details. Relevant to a manager to see who has had their membership expire, 
#so that they can send a renewal request. Also helps with budgeting if the member wishes to have their membership terminated.
SELECT 
    m.memberID,
    m.memberFirstName,
    m.memberLastName,
    m.membershipType,
    m.joinDate,
    m.expirationDate
FROM Members AS m
WHERE m.expirationDate < CURDATE();

#3, This query retrieves details of vendors who have provided products for recent transactions within the last year. 
#It helps the manager identify the active vendors who are supplying products. (active vendors with recent transactions)
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

#2, Query retrieves members who have paid the most during a transaction, listing the members and their receipt costs. 
#Helps a manager see who is willing to spend the most in a single outing, which could lead to them spending more in the future.
SELECT
memberID,
memberFirstName,
memberLastName,
(SELECT MAX(amount)
FROM Transaction
WHERE Members_memberID=M.memberID)
AS MaxTransactionAmount
FROM Members M;

#4, Query keeps track of tournament participation between members and the total amount they have paid in registering. 
#Helps managers see who is entering high-paying tournaments, which would help them encourage the members to keep participating in the future.
SELECT DISTINCT memberFirstName, memberLastName, SUM(Participation.registrationFee)
FROM Members
JOIN Participation ON Members.memberID=Participation.Members_memberID
JOIN Tournaments ON Participation.Tournaments_eventID=Tournaments.eventID
GROUP BY memberFirstName, memberLastName;

#5, Query analyses the enrollment of members in coaching sessions. 
#It helps the manager understand the popularity of coaching programs among members. (Member enrollment in coaching sessions)
SELECT Members_memberID,
COUNT(*) AS TotalSessions
FROM CoachingSession
GROUP BY Members_memberID
ORDER BY TotalSessions DESC;

#6, Query retrieves the coaches who hold more than 5 coaching sessions. 
#Helps managers see which coaches are favored by the clientele and possibly helps show initiative on part of the coaches.
SELECT Coach_coachID, COUNT(*) AS TotalSessions
FROM CoachingSession
GROUP BY Coach_coachID
HAVING TotalSessions > 5;

#7, Query identifies the most expensive pro shop items available for sale. 
#It helps the manager understand the pricing structure of the pro shop. (Most expensive pro shop item identification)
SELECT productID, productName, category, productPrice
FROM ProShopItem
ORDER BY productPrice DESC;

#8, Query identifies the top-selling pro shop items based on the total quantity sold. 
#It helps the manager understand the popularity of different products and optimise inventory management. (Top-selling pro shop item identification)

SELECT PSI.productID, PSI.productName, PSI.category,
SUM(P.qtyPurchased) AS TotalQuantitySold
FROM ProShopItem AS PSI
JOIN Receipt AS R ON PSI.productID = R.ProShopItem_productID
JOIN Purchase AS P ON R.Purchase_purchaseID=P.purchaseID
GROUP BY PSI.productID, PSI.productName, PSI.category
ORDER BY TotalQuantitySold DESC;

#9, Query retrieves details of active members whose memberships have not expired. It helps the manager keep track of the current membership base. (active members)
SELECT ER.rentalID, CONCAT(M.memberFirstName, ' ', M.memberLastName) AS MemberName,
E.equipmentName 
FROM EquipmentRentals AS ER
JOIN Members AS M ON ER.Members_memberID=M.memberID
JOIN EquipmentRentals AS E ON ER.equipmentName=E.equipmentName;

#10, Query that displays coaching lessons for kids done by an expert coach. 
#This would be helpful information for high-spending club members who want to raise their kids how to play tennis at a high level from a young age. 
SELECT programName, programType, programSchedule
FROM Lessons AS L
WHERE programType REGEXP 'Glorified Daycare'
AND EXISTS (
SELECT TRUE
FROM Coach AS C
WHERE C.coachID = L.Coach_coachID
AND C.certificationLevel = 'expert');
