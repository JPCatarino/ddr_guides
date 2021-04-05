% Task 2
% See semilogx, semilogy, logplot

%2a
% f(0) = (n 0) * p^0 * (1-p)^(n-0)
n = 100 * 8;
p = 10 ^ -2;
i = 0;

res = (nchoosek(n, i) * p^i * (1 - p)^(n - i)) * 100

%2b
n = 1000 * 8;
p = 10 ^ -3;
i = 1;

res = (nchoosek(n, i) * p^i * (1 - p)^(n - i)) * 100

%2c
n = 200 * 8;
p = 10 ^ -4;
i = 0;

res = (1 - (nchoosek(n, i) * p^i * (1 - p)^(n - i))) * 100

%2d
p = logspace(-8, -2);
i = 0;

n = [100, 200, 1000]*8;

f1 = (nchoosek(n(1), i) .* p.^i .* (1 - p).^(n(1) - i)) * 100;
f2 = (nchoosek(n(2), i) .* p.^i .* (1 - p).^(n(2) - i)) * 100;
f3 = (nchoosek(n(3), i) .* p.^i .* (1 - p).^(n(3) - i)) * 100;

figure(1);
semilogx(p, f1, 'b-', p, f2, 'b--', p, f3, 'b:');
grid on
title("Probabilidade de receber o pacote sem erros(%)")
xlabel('Bit Error Rate')
legend('100 Bytes', '200 Bytes', '1000 Bytes', 'location', 'southwest')

%2e
n = linspace(64, 1518)
i = 0;

p = [(10^-4), (10^-3), (10^-2)];

f1 = (1 * p(1)^i * (1 - p(1)).^(n - i)) * 100;
f2 = (1 * p(2)^i * (1 - p(2)).^(n - i)) * 100;
f3 = (1 * p(3)^i * (1 - p(3)).^(n - i)) * 100;

figure(1);
semilogy(n, f1, 'b-', n, f2, 'b--', n, f3, 'b:');
grid on
title("Probabilidade de receber o pacote sem erros(%)")
xlabel('Packet Size (Bytes)')
legend('ber=1e-4', 'ber=1e-3', 'ber=1e-2', 'location', 'southwest')
