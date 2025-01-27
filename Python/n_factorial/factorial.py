class Answer:
    def decomp(self, n):
        res = []  # Список простых чисел
        ges = {}  # Список всех значений
        stepen = [] # Список степеней

        # Находим простые числа до n
        for i in range(2, n + 1):
            is_prime = True
            for j in range(2, int(i**0.5) + 1):
                if i % j == 0:
                    is_prime = False
                    break
            if is_prime:
                res.append(i)

        # Вычисляем значения для каждого простого числа
        for item in res:
            total_sum = 0 
            k = 1
            while item**k <= n: # Цикл суммы всех item
                total_sum += n // (item**k)  
                k += 1  
            ges[item] = total_sum  
            stepen.append(total_sum)
        
        prod = 1
        for item in range(len(res)):
            prod *= res[item] ** stepen[item]  # Цикл умножения
        
        return prod


# Тестируем функцию
print(Answer().decomp(n=22))