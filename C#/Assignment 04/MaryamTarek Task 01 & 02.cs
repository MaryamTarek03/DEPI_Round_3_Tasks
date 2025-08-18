namespace Assignment_04;

static class Program {
    class Methods
    {
        public static void CanVote(string name, int age) =>
            Console.WriteLine(age < 18 ? $"Sorry {name}, you are too young to vote." : $"You are old enough to vote.");

        public static string CanVoteReturn(string name, int age) =>
            age < 18 ? $"Sorry {name}, you are too young to vote." : $"You are old enough to vote.";
    }
    static void Main(string[] args)
    {
        Methods.CanVote("Maryam", 21);
        Console.WriteLine(Methods.CanVoteReturn("Muhammad", 16));
    }
}