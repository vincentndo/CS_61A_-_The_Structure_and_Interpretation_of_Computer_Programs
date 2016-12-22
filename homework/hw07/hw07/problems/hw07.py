class Fib():
    """A Fibonacci number.

    >>> start = Fib()
    >>> start
    0
    >>> start.next()
    1
    >>> start.next().next()
    1
    >>> start.next().next().next()
    2
    >>> start.next().next().next().next()
    3
    >>> start.next().next().next().next().next()
    5
    >>> start.next().next().next().next().next().next()
    8
    """

    def __init__(self):
        self.value = 0

    def next(self):
        "*** YOUR CODE HERE ***"
        
        if self.value == 0:
            ret = Fib()
            ret.previous = 0
            ret.value = 1
            return ret
        else:
            temp = self.previous
            self.previous = self.value
            self.value += temp
            return self

    def __repr__(self):
        return str(self.value)

class VendingMachine:
    """A vending machine that vends some product for some price.

    >>> v = VendingMachine('candy', 10)
    >>> v.vend()
    'Machine is out of stock.'
    >>> v.restock(2)
    'Current candy stock: 2'
    >>> v.vend()
    'You must deposit $10 more.'
    >>> v.deposit(7)
    'Current balance: $7'
    >>> v.vend()
    'You must deposit $3 more.'
    >>> v.deposit(5)
    'Current balance: $12'
    >>> v.vend()
    'Here is your candy and $2 change.'
    >>> v.deposit(10)
    'Current balance: $10'
    >>> v.vend()
    'Here is your candy.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'

    >>> w = VendingMachine('soda', 2)
    >>> w.restock(3)
    'Current soda stock: 3'
    >>> w.deposit(2)
    'Current balance: $2'
    >>> w.vend()
    'Here is your soda.'
    """
    "*** YOUR CODE HERE ***"
    def __init__(self, item, price):
        self.item = item
        self.num_item = 0
        self.price = price
        self.balance = 0

    def restock(self, num_item):
        self.num_item += num_item
        return 'Current {} stock: {}'.format(self.item, self.num_item)

    def deposit(self, amount):
        if self.num_item == 0:
            return 'Machine is out of stock. Here is your $' + str(amount) + '.'

        self.balance += amount
        return 'Current balance: $' + str(self.balance)

    def vend(self):
        if self.num_item == 0:
            return 'Machine is out of stock.'
        else:
            if self.balance < self.price:
                return 'You must deposit $' + str(self.price - self.balance) + ' more.'
            elif self.balance == self.price:
                self.balance = 0
                self.num_item -= 1
                return 'Here is your ' + str(self.item) + '.'
            else:
                change = self.balance - self.price
                ret = 'Here is your {} and ${} change.'.format(self.item, change)
                self.balance = 0
                self.num_item -= 1
                return ret

class MissManners:
    """A container class that only forward messages that say please.

    >>> v = VendingMachine('teaspoon', 10)
    >>> v.restock(2)
    'Current teaspoon stock: 2'

    >>> m = MissManners(v)
    >>> m.ask('vend')
    'You must learn to say please first.'
    >>> m.ask('please vend')
    'You must deposit $10 more.'
    >>> m.ask('please deposit', 20)
    'Current balance: $20'
    >>> m.ask('now will you vend?')
    'You must learn to say please first.'
    >>> m.ask('please hand over a teaspoon')
    'Thanks for asking, but I know not how to hand over a teaspoon.'
    >>> m.ask('please vend')
    'Here is your teaspoon and $10 change.'

    >>> double_fussy = MissManners(m) # Composed MissManners objects
    >>> double_fussy.ask('deposit', 10)
    'You must learn to say please first.'
    >>> double_fussy.ask('please deposit', 10)
    'Thanks for asking, but I know not how to deposit.'
    >>> double_fussy.ask('please please deposit', 10)
    'Thanks for asking, but I know not how to please deposit.'
    >>> double_fussy.ask('please ask', 'please deposit', 10)
    'Current balance: $10'
    """
    def __init__(self, obj):
        self.obj = obj

    def ask(self, message, *args):
        magic_word = 'please '
        if not message.startswith(magic_word):
            return 'You must learn to say please first.'
        "*** YOUR CODE HERE ***"
        request = message[7:]
        # print(request)
        # if not isinstance(self, MissManners):
        #     if hasattr(self, request):
        #         print('here')
        #         getattr(self, request)(*args)
        #     else:
        #         return 'Thanks for asking, but I know not how to ' + request
        # else:
        #     if hasattr(self.obj, request):
        #         getattr(self.obj, request)(*args)
        #     else:
        #         return 'Thanks for asking, but I know not how to ' + request

        if hasattr(self.obj, request):
            return getattr(self.obj, request)(*args)
        else:
            return 'Thanks for asking, but I know not how to ' + request + '.'
