namespace Assignment_03;

static class Program
{
    interface IGameCharacter
    {
        void Attack();
        void Defend();
    }

    class Warrior : IGameCharacter
    {
        public void Attack() =>
            Console.WriteLine("Warrior attacks with a sword!");

        public void Defend() =>
            Console.WriteLine("Warrior defends with a shield!");
    }

    class Mage : IGameCharacter
    {
        public void Attack() =>
            Console.WriteLine("Mage casts a fireball!");

        public void Defend() =>
            Console.WriteLine("Mage creates a magical barrier!");
    }
    static void Main(string[] args)
    {
        IGameCharacter warrior = new Warrior();
        IGameCharacter mage = new Mage();

        warrior.Attack();
        warrior.Defend();

        mage.Attack();
        mage.Defend();
    }
}