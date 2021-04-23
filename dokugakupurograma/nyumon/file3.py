import csv


with open("st.csv","w") as f:
    w = csv.writer(f,delimiter = ",")
    w.writerow(["Top Gun","Risky Business","Minority Report"])
    w.writerow(["Titanic", "The Revenant", "Inception"])
    w.writerow(["Training Day", "Man on Fire", "Flight"])

