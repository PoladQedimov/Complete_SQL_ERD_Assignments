# ERD izahları — Projects A və B

## Project A — Sales management (A1–A7)

**A1 — Primary keys:** `Customers.CustomerID`, `Products.ProductID`, `Employees.EmployeeID`, `Orders.OrderID`.

**A2 — Foreign keys:**

| Foreign key | References | İzah |
| --- | --- | --- |
| `Orders.CustomerID` | `Customers.CustomerID` | Sifarişin sahibi |
| `Orders.ProductID` | `Products.ProductID` | Sifarişdəki bir məhsul |
| `Orders.SalesPersonID` | `Employees.EmployeeID` | Sifarişi idarə edən əməkdaş |
| `Employees.ManagerID` | `Employees.EmployeeID` | Əməkdaşın rəhbəri; `NULL` ola bilər |

**A3–A4:** `project_a_sales.png` və `project_a_sales.pdf` fayllarında dörd cədvəlin **bütün sahələri**, PK/FK işarələri və əlaqə xətləri göstərilib. `project_a_sales.mmd` isə GitHub-da göstərilə bilən Mermaid mənbəyidir.

**A5–A7 — Cardinality və optionality:**

- **Customers (1) → Orders (0..N):** Bir müştərinin sıfır və ya çox sifarişi ola bilər; hər sifariş mütləq bir müştəriyə aiddir.
- **Products (1) → Orders (0..N):** Bir məhsul çox sifarişdə iştirak edə bilər; hər sifariş bu sadələşdirilmiş sxemdə yalnız bir məhsula istinad edir.
- **Employees (1) → Orders (0..N):** Bir əməkdaş çox sifarişə cavabdeh ola bilər; hər sifarişin bir məsul əməkdaşı var.
- **Employees (manager 0..1) ↔ Employees (staff 0..N):** Əməkdaşın rəhbəri olmaya bilər (`ManagerID IS NULL`) və ya yalnız bir rəhbəri ola bilər. Rəhbərin sıfır və ya çox birbaşa tabeliyində əməkdaşı ola bilər.

> Qeyd: Bu layihədə `Orders` yalnız bir məhsul saxlayır; tapşırıqlar üçün ayrıca `OrderItems` cədvəli yaradılmır.

## Project B — University course registration (B1–B7)

**B1 — Primary keys:** `Students.StudentID`, `Instructors.InstructorID`, `Courses.CourseID`, `Enrollments.EnrollmentID`.

**B2 — Foreign keys:**

| Foreign key | References | İzah |
| --- | --- | --- |
| `Courses.InstructorID` | `Instructors.InstructorID` | Kursun müəllimi |
| `Enrollments.StudentID` | `Students.StudentID` | Qeydiyyatdan keçən tələbə |
| `Enrollments.CourseID` | `Courses.CourseID` | Qeydiyyatdan keçilən kurs |

**B3–B4:** Bütün sütunlar, tiplər, PK/FK işarələri və əlaqələr `project_b_university.png`/`.pdf` şəkillərindədir.

**B5–B6 — Əlaqələr:**

- **Instructors (1) → Courses (0..N):** Bir müəllim bir neçə kurs tədris edə bilər; hər kursun bir müəllimi var.
- **Students (1) → Enrollments (0..N):** Bir tələbə çox kursa qeydiyyatdan keçə bilər.
- **Courses (1) → Enrollments (0..N):** Bir kursda çox tələbə ola bilər.
- **Students ↔ Courses (M:N):** Bu çoxdan-çoxa əlaqə `Enrollments` adlı aralıq cədvəl vasitəsilə iki **1:N** əlaqəyə çevrilir. `EnrollmentDate`, `Grade` və `Status` həmin qeydiyyata məxsus məlumatlardır.

**B7 — Təkrar qeydiyyatın qarşısının alınması:** `UNIQUE (StudentID, CourseID)` eyni tələbə və eyni kurs cütlüyünün ikinci dəfə əlavə edilməsini bloklayır. `EnrollmentID` isə hər qeydiyyat sətrinin öz unikal identifikatorudur.

İstəyə görə işlək SQL versiyası: `../sql/08_university_schema.sql`. PDF-də bu layihə üçün SQL kodu tələb olunmur, ancaq əlavə olaraq hazırlanıb.
