static class Program
{
    private static readonly List<Customer> Customers = [];

    private class Customer(
        string firstName,
        string lastName,
        string cardNumber,
        int pinCode)
    {
        public string FirstName { get; set; } = firstName;
        public string LastName { get; set; } = lastName;
        public string CardNumber { get; set; } = cardNumber;
        private int PinCode { get; set; } = pinCode;
        private double Balance { get; set; }

        public bool Deposit(double amount)
        {
            if (!(amount > 0)) return false;
            Balance += amount;
            return true;
        }

        public bool Withdraw(double amount)
        {
            if (amount <= 0 || amount > Balance) return false;
            Balance -= amount;
            return true;
        }

        public void ShowBalance() => Console.WriteLine($"Your current balance is: {Balance}$");

        public bool ValidatePinCode(int pinCode) => this.PinCode == pinCode;
    }

    static void Main()
    {
        Customers.Add(new Customer("Maryam", "Tarek", "11111111", 1234));
        Customers.Add(new Customer("John", "Doe", "12345678", 12345678));
        Customers.Add(new Customer("Jane", "Doe", "11110000", 12345678));
        Customer customer;
        var flag = true;
        while (!TryGetCustomer(out customer));
        while (flag)
        {
            if(!TryGetPinCode(out var pinCode))
                continue;
           
            if (customer.ValidatePinCode(pinCode))
                flag = false;
            else Console.WriteLine("Incorrect pin code");
        }
        
        Console.WriteLine($"Hello {customer.FirstName}, welcome to our bank <3");
        
        int option = 0;
        while (option != 4)
        {
            option = GetOption();
            switch (option)
            {
                case 1:
                    var deposit = GetAmount();
                    customer.Deposit(deposit);
                    Console.WriteLine($"Operation Successful: Deposited {deposit}$");
                    customer.ShowBalance();
                    break;
                case 2:
                    var withdraw = GetAmount();
                    Console.WriteLine(!customer.Withdraw(withdraw)
                        ? "You don't have enough balance"
                        : $"Operation Successful: Withdrawn {withdraw}$");
                    customer.ShowBalance();
                    break;
                case 3:
                    customer.ShowBalance();
                    break;
                case 4:
                    Console.WriteLine($"Goodbye {customer.FirstName}! Thanks for using our bank!");
                    break;
            }
        }
    }

    private static double GetAmount()
    {
        double amount;
        Console.WriteLine("Please enter the wanted amount (1 - 99999)");
        while (!double.TryParse(Console.ReadLine(), out amount) || amount < 1 || amount > 99999)
            Console.Write("Please enter a valid number from 1 to 99999: ");
        return amount;
    }

    private static bool TryGetPinCode(out int pinCode)
    {
        Console.Write("Please enter Pin Code: ");
        if (int.TryParse(Console.ReadLine(), out pinCode)) return true;
        Console.WriteLine("Please enter a valid Pin Code");
        return false;
    }
    private static bool TryGetCustomer(out Customer customer)
    {
        Console.Write("Please enter card number: ");
        var cardNumber = Console.ReadLine() ?? string.Empty;
        if (!int.TryParse(cardNumber, out _) || cardNumber.Length == 0)
        {
            Console.WriteLine("Please enter a valid number");
            customer = null!;
            return false;
        }
        customer = Customers.Find(c => c.CardNumber == cardNumber)!;
        if (customer != null!) return true;
        Console.WriteLine("Invalid card number, user does not exist");
        return false;
    }

    private static int GetOption()
    {
        Console.WriteLine("-----------------------------------------");
        Console.WriteLine("Please select an option from the menu: ");
        Console.WriteLine("-----------------------------------------");
        Console.WriteLine("1. Deposit");
        Console.WriteLine("2. Withdraw");
        Console.WriteLine("3. Show Balance");
        Console.WriteLine("4. Exit");
        _ = int.TryParse(Console.ReadLine(), out var optionValue) ? optionValue : 0;
        return optionValue;
    }
}