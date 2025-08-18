namespace Assignment_03;

static class Program
{
    abstract class Entity
    {
        protected int Health;
        protected int MaxHealth;
        protected Entity(int initialHealth, int maxHealth)
        {
            this.Health = initialHealth;
            this.MaxHealth = maxHealth;
        }

        public void Damage(int amount = 0)
        {
            Health -= amount;
            if (Health < 0)
                Health = 0;
        }

        public abstract void DisplayStatus();
    }

    class Player : Entity
    {
        public int Level { get; private set; } = 1;
        public Player() : base(100, 100) { }
        public void LevelUp()
        {
            Level++;
            MaxHealth += 20;
            Health = MaxHealth; // heal on level up for example
        }

        public override void DisplayStatus()
        {
            Console.WriteLine($"Player Status: Level {Level}, Health {Health}/{MaxHealth}");
        }
    }

    class Enemy : Entity
    {
        public int Strength { get; private set; }
        public Enemy(int strength) : base(50, 50) => Strength = strength;
        public int Attack() => Strength; // enemy damage
        public override void DisplayStatus()
        {
            Console.WriteLine($"Enemy Status: Health {Health}/{MaxHealth}, Strength {Strength}");
        }
    }

    static void Main(string[] args)
    {
        Player player = new Player();
        Enemy enemy = new Enemy(10);
        
        enemy.Damage(20);
        player.Damage(30);

        player.LevelUp();
        int enemyAttackDamage = enemy.Attack();
        player.Damage(enemyAttackDamage);
        
        player.DisplayStatus();
        enemy.DisplayStatus();
    }
}