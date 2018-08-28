--Pig counts Mary and her lamb
input = load 'mary' as (line);
words = foreach input generate flatten(TOKENIZE(line)) as word;
grpd = group words by word;
cntd = foreach grpd generate group, COUNT(words);
dump cntd;

--Group then join in Pig Latin
txns = load 'transactions' as (customer, purchase);
grouped = group txns by customer;
total = foreach grouped generate group, SUM(txns.purchase) as tp;

profile = load 'customer_profile' as (customer, zipcode);
answer = join total by group, profile by customer;
dump answer;

--Finding the top five URLs
Users = load 'users' as (name, age);
Fltrd = filter Users by age >= 18 and age <= 25;

Pages = load 'pages' as (user, url);

Jnd = join Fltrd by name, Pages by user;
Grpd = group Jnd by url;
Smmd = foreach Grpd generate group, COUNT(Jnd) as clicks;
Srtd = order Smmd by clicks desc;
Top5 = limit Srtd 5;
store Top5 into 'top5sites';

--Running Pig in local mode
dividends = load 'NYSE_dividends' as (exchange, symbol, date, dividend);
grouped = group dividends by symbol;
avg = foreach grouped generate group, AVG(dividends.dividend);
store avg into 'average_dividend';


//pig -e fs -ls or fs -ls
exec-  
run - all aliases referenced in script are available to Grunt
