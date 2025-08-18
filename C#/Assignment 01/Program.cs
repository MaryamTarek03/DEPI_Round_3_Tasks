namespace Assignment_01;

static class Program
{
    class Game
    {
        public delegate void WinDelegate();
        public event WinDelegate? WinEvent;
        public int Score { get; set; } = 0;

        public void OnWinEvent() => WinEvent?.Invoke();
    }
    static void Main()
    {
        Game game = new Game();
        game.WinEvent += () => { game.Score++; };
        game.WinEvent += () =>
        {
            Console.WriteLine("----------------------");
            Console.WriteLine("Game Won!");
            Console.WriteLine($"Score: {game.Score}");
            Console.WriteLine("----------------------");
        };
        game.WinEvent += () => { Console.WriteLine("Opening Menu..."); };
        
        game.OnWinEvent();
        game.OnWinEvent();
        game.OnWinEvent();
    }
}