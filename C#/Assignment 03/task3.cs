namespace Assignment_03;

static class Program
{
    class Student
    {
        public string Name { get; set; }
        public int Grade { get; set; }
        public Student(string name, int grade)
        {
            Name = name;
            Grade = grade;
        }
        public override string ToString() => $"{Name}: Grade {Grade}";
    }
    class CustomList<T>
    {
        private readonly List<T> _items = new List<T>();
        public void Add(T item) => _items.Add(item);
        public void DisplayAll()
        {
            foreach (var item in _items)
                Console.WriteLine(item);
        }
    }

    static void Main(string[] args)
    {
        var students = new CustomList<Student>();
        students.Add(new Student("Maryam", 95));
        students.Add(new Student("Ali", 88));
        students.Add(new Student("Noor", 90));
        students.Add(new Student("Omar", 85));
        students.Add(new Student("Salma", 92));

        students.DisplayAll();
    }
}