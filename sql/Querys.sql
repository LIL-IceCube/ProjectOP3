
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



SELECT 
  Afkeurreden,
  SUM(AantalAfgekeurd) AS TotaalAfgekeurd
FROM KwaliteitCheck
GROUP BY Afkeurreden
ORDER BY TotaalAfgekeurd DESC;

SELECT 'Grinding' AS Proces, ROUND(AVG(gp.Aantal), 2) AS GemiddeldAantal FROM Grinding_Product gp
UNION
SELECT 'Filling', ROUND(AVG(fp.Aantal), 2) FROM Filling_Product fp
UNION
SELECT 'Packaging', ROUND(AVG(pp.Aantal), 2) FROM Packaging_Product pp;


SELECT 'Controlestatus' AS Stap, CStatusProduct AS Status, COUNT(*) AS Aantal FROM Product GROUP BY CStatusProduct
UNION
SELECT 'Vulstatus', FStatusProduct, COUNT(*) FROM Product GROUP BY FStatusProduct
UNION
SELECT 'Verpakstatus', PStatusProduct, COUNT(*) FROM Product GROUP BY PStatusProduct;


SELECT 
  kc.Afkeurreden,
  COUNT(*) AS AantalChecks,
  SUM(kc.AantalAfgekeurd) AS TotaalAfgekeurd,
  ROUND(SUM(kc.AantalAfgekeurd) / COUNT(*) , 2) AS GemAfkeurPerCheck
FROM KwaliteitCheck kc
WHERE kc.AantalAfgekeurd > 0
GROUP BY kc.Afkeurreden
ORDER BY TotaalAfgekeurd DESC
LIMIT 5;

SELECT 
  p.ProductID,
  TIMESTAMPDIFF(MINUTE, g.G_DatumTijdEind, f.F_DatumTijdStart) AS Tussen_G_F,
  TIMESTAMPDIFF(MINUTE, f.F_DatumTijdEind, pa.P_DatumTijdStart) AS Tussen_F_P,
  (
    TIMESTAMPDIFF(MINUTE, g.G_DatumTijdEind, f.F_DatumTijdStart) +
    TIMESTAMPDIFF(MINUTE, f.F_DatumTijdEind, pa.P_DatumTijdStart)
  ) AS Totale_Wachttijd
FROM Product p
JOIN Grinding_Product gp ON p.ProductID = gp.ProductID
JOIN Grinding g ON gp.GrindingID = g.GrindingID
JOIN Filling_Product fp ON p.ProductID = fp.ProductID
JOIN Filling f ON fp.FillingID = f.FillingID
JOIN Packaging_Product pp ON p.ProductID = pp.ProductID
JOIN Packaging pa ON pp.PackagingID = pa.PackagingID;



