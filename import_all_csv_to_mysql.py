import mysql.connector
import pandas as pd

# Verbinden met de MySQL database
conn = mysql.connector.connect(
    host="localhost",
    port=8889,
    user="root",
    password="root",
    database="EuroCapsDB"
)
cursor = conn.cursor()

# Alle CSV-bestanden gekoppeld aan hun tabellen
csv_table_map = {
    "soort_partner.csv": "Soort_partner",
    "partnercontact.csv": "PartnerContact",
    "levering.csv": "Levering",
    "partner.csv": "Partner",
    "soortproduct.csv": "SoortProduct",
    "kwaliteitcheck.csv": "KwaliteitCheck",
    "operator.csv": "Operator",
    "product.csv": "Product",
    "leveringregel.csv": "LeveringRegel",
    "proceslog.csv": "ProcesLog",
    "grinding.csv": "Grinding",
    "grinding_product.csv": "Grinding_Product",
    "filling.csv": "Filling",
    "filling_product.csv": "Filling_Product",
    "packaging.csv": "Packaging",
    "packaging_product.csv": "Packaging_Product"
}

# Inlezen en invoegen
for csv_file, table in csv_table_map.items():
    try:
        print(f"Inlezen: {csv_file} → {table}")
        df = pd.read_csv(csv_file)
        df = df.astype(str)  # Zorg dat alles als string komt voor veiligheid bij insert
        columns = ", ".join(df.columns)
        placeholders = ", ".join(["%s"] * len(df.columns))
        sql = f"INSERT IGNORE INTO {table} ({columns}) VALUES ({placeholders})"
        data = [tuple(row) for row in df.values]
        cursor.executemany(sql, data)
        conn.commit()
        print(f"{cursor.rowcount} records ingevoerd in {table}")
    except Exception as e:
        print(f"FOUT bij {table}: {e}")

cursor.close()
conn.close()
print("Import voltooid.")
