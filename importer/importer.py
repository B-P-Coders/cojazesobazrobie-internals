import psycopg2
import csv

conn = psycopg2.connect(
    database="cojazrobie",
    user='falke',
    password='falcon',
    host='localhost',
    port='5432'
)

cur = conn.cursor()

def importfile(file):
    df = csv.DictReader(file)
    for row in df:
        insert_row(row)

def prepare(d):
    if type(d) is int:
        return str(d)
    elif type(d) is bool:
        if d:
            return "true"
        else:
            return "false"
    elif type(d) is str:
        if d == '':
            return "NULL"
        else:
            return "'" + d.replace("'", "") + "'"
    else:
        print(d)
        return str(d)

def insert_row(row):
    obj = dict()
    obj['name'] = row['Nazwa']
    obj['institution'] = row['Instytucja prowadząca']
    obj['level'] = row['Poziom']
    obj['profile'] = row['Profil']
    obj['isced_id'] = row['Klasyfikacja ISCED (kod)']
    obj['isced_name'] = row['Klasyfikacja ISCED (nazwa)']
    obj['create_date'] = row['Data utworzenia']
    obj['is_for_teacher'] = row['Czy studia przygotowują do zawodu nauczyciela'] != "Nie"
    obj['language_list'] = row['Lista języków dla filologii obcej']
    obj['is_shared'] = row['Studia wspólne'] != "Nie"
    obj['status'] = row['Status']
    obj['expire_date'] = row['Data początku wygaszania']
    obj['del_date'] = row['Data likwidacji']
    obj['trades'] = row['Dyscypliny']
    obj['cooperator_id'] = row['Instytucje współprowadzące - Uuid instytucji współprowadzącej']
    obj['cooperator_name'] = row['Instytucje współprowadzące - Nazwa instytucji współprowadzącej']
    obj['is_abroad_cooperator'] = row['Instytucje współprowadzące - Czy zagraniczna'] != "Nie"
    obj['cooperation_start_date'] = row['Instytucje współprowadzące - Data początku współprowadzenia studiów przez daną instytucję']
    obj['cooperation_end_date'] = row['Instytucje współprowadzące - Data końca współprowadzenia studiów przez daną instytucję']
    obj['run_name'] = row['Uruchomienie - Nazwa']
    obj['run_form'] = row['Uruchomienie - Forma']
    obj['run_title'] = row['Uruchomienie - Tytuł zawodowy']
    obj['run_lang'] = row['Uruchomienie - Język kształcenia']
    obj['run_date'] = row['Uruchomienie - Data uruchomienia']
    obj['semester_count'] = row['Uruchomienie - Liczba semestrów']
    obj['ects_count'] = row['Uruchomienie - ECTS']
    obj['is_dual'] = row['Uruchomienie - Studia dualne'] != "Nie"
    obj['run_status'] = row['Uruchomienie - Status']
    obj['is_work_cooperation'] = row['Uruchomienie - We współpracy z organizacją zawodową'] != "Nie"

    cols = [str(e) for e in obj.keys()]
    data = [(prepare(obj[c])) for c in cols]
    stmt = f"INSERT INTO studies({','.join(cols)}) VALUES ({','.join(data)});"
    print(stmt)
    cur.execute(stmt)



for i in range(1, 2):
    with open(f"zestawienie.csv") as datafile:
        importfile(datafile)

conn.commit()
