
-- ✅ OPERATIONELE INZICHTEN --

-- 1. Aantal producten per productstatus
SELECT CStatusProduct AS Status, COUNT(*) AS Aantal FROM Product GROUP BY CStatusProduct;

-- 2. Leveringen met het aantal unieke producten
SELECT LeveringID, COUNT(DISTINCT ProductID) AS AantalUniekeProducten FROM LeveringRegel GROUP BY LeveringID;

-- 3. Gemiddelde aantallen per levering
SELECT LeveringID, AVG(Aantal) AS GemiddeldAantal FROM LeveringRegel GROUP BY LeveringID;

-- 4. Aantal producten per soort
SELECT sp.Omschrijving, COUNT(*) AS Aantal FROM Product p JOIN SoortProduct sp ON p.SoortProductID = sp.SoortProductID GROUP BY sp.Omschrijving;

-- 5. Meest voorkomende processtatus (Filling)
SELECT FStatusProduct, COUNT(*) AS Aantal FROM Product GROUP BY FStatusProduct ORDER BY Aantal DESC LIMIT 1;

-- 6. Laatst geleverde producten
SELECT l.LeveringID, l.LeveringDatum, lr.ProductID FROM Levering l JOIN LeveringRegel lr ON l.LeveringID = lr.LeveringID ORDER BY l.LeveringDatum DESC LIMIT 5;

-- 7. Actieve operators per proces
SELECT o.NaamOperator, COUNT(DISTINCT g.GrindingID) AS GrindingTaken, COUNT(DISTINCT f.FillingID) AS FillingTaken, COUNT(DISTINCT p.PackagingID) AS PackagingTaken
FROM Operator o
LEFT JOIN Grinding g ON o.OperatorID = g.OperatorID
LEFT JOIN Filling f ON o.OperatorID = f.OperatorID
LEFT JOIN Packaging p ON o.OperatorID = p.OperatorID
GROUP BY o.OperatorID;

-- 8. Producten met afkeur
SELECT kc.KwaliteitCheckID, kc.Afkeurreden, kc.AantalAfgekeurd, p.ProductID
FROM KwaliteitCheck kc
JOIN Product p ON kc.KwaliteitCheckID = p.KwaliteitCheckID
WHERE kc.AantalAfgekeurd > 0;

-- ✅ KPI-INSIGHTS --

-- 9. Gemiddelde doorlooptijd per proces (in minuten)
SELECT 'Grinding' AS Proces, AVG(TIMESTAMPDIFF(MINUTE, G_DatumTijdStart, G_DatumTijdEind)) AS Minuten FROM Grinding
UNION
SELECT 'Filling', AVG(TIMESTAMPDIFF(MINUTE, F_DatumTijdStart, F_DatumTijdEind)) FROM Filling
UNION
SELECT 'Packaging', AVG(TIMESTAMPDIFF(MINUTE, P_DatumTijdStart, P_DatumTijdEind)) FROM Packaging;

-- 10. Aantal producten per dag verwerkt (Filling)
SELECT DATE(F_DatumTijdStart) AS Datum, COUNT(*) AS Aantal FROM Filling GROUP BY Datum;

-- 11. Gemiddeld aantal stuks per doos (Packaging)
SELECT AVG(AantalStuksInDoos) AS GemiddeldPerDoos FROM Packaging;

-- 12. Top 3 operators met meeste verpakkingen
SELECT o.NaamOperator, COUNT(*) AS AantalPackaging
FROM Packaging p
JOIN Operator o ON p.OperatorID = o.OperatorID
GROUP BY o.OperatorID
ORDER BY AantalPackaging DESC
LIMIT 3;

-- 13. Aantal producten per processtap aanwezig in ProcesLog
SELECT ProcesStap, COUNT(*) AS Aantal FROM ProcesLog GROUP BY ProcesStap;

-- 14. Aantal producten zonder afkeur (OK-status bij alle stappen)
SELECT COUNT(*) AS TotaalOK
FROM Product
WHERE CStatusProduct = 'OK' AND FStatusProduct = 'OK' AND PStatusProduct = 'OK';

-- 15. Gemiddeld aantal gebruikte producten per proces
SELECT 'Grinding' AS Proces, AVG(Aantal) FROM Grinding_Product
UNION
SELECT 'Filling', AVG(Aantal) FROM Filling_Product
UNION
SELECT 'Packaging', AVG(Aantal) FROM Packaging_Product;
