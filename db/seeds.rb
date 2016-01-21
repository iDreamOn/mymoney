User.import([:id, :first_name, :last_name, :email, :username, :encrypted_password, :created_at, :updated_at, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at], [
  [2, "Dev", "Dev", "dev@local.com", "dev", "$2a$10$MQXBLoTi4vAnoJ/YkzWuDuphjbQ0QqCN5diUUmxiHmCcZ3T9MY9lW", "2015-12-17 15:52:55", "2016-01-21 02:59:24", nil, nil, nil, 4, "2016-01-21 01:06:35", "2016-01-20 21:56:26", "10.0.2.2", "10.0.2.2", nil, "2016-01-21 01:06:35", nil, nil, 0, nil, nil],
  [3, "dev2", "dev2", "dev2@local.com", "dev2", "$2a$10$uUeDHDYOAySxzf.ow18Yiu7ymkfOIir38mFafyrFWBli4AilOEfBa", "2015-12-25 03:50:00", "2016-01-21 02:59:24", nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, 0, nil, nil]
], validate: false)
Account.import([:id, :user_id, :name, :account_type, :created_at, :updated_at], [
  [1, 2, "Chase", "Checkings", "2015-12-19 13:23:49", "2016-01-21 02:59:24"],
  [2, 2, "Bank Of America", "Checkings", "2015-12-19 18:53:28", "2016-01-21 02:59:24"],
  [5, 3, "Bank of America", "Checking", "2015-12-25 05:10:32", "2016-01-21 02:59:24"]
])
Category.import([:id, :name, :description, :created_at, :updated_at, :user_id], [
  [1, "Automotive, Home & Games", "Awesome Silk Bench", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 2],
  [2, "Beauty, Music & Automotive", "Ergonomic Paper Bench", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 2],
  [3, "Garden, Health, Books, Industrial & Home", "Durable Iron Clock", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 2],
  [4, "Loans", "All loans", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 2],
  [5, "Credit Cards", "Credit Card Payment", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 2],
  [6, "Savings", "all savings", "2015-09-26 02:31:05", "2016-01-21 02:59:24", 2],
  [7, "Rent", "Rent", "2015-11-28 05:04:41", "2016-01-21 02:59:24", 2],
  [9, "Bill", "All loans", "2015-12-25 05:33:44", "2016-01-21 02:59:24", 3],
  [10, "Loans", "All loans", "2015-12-25 05:42:59", "2016-01-21 02:59:24", 3],
  [11, "Credit Cards", "Credit Card Payments", "2015-12-25 09:26:54", "2016-01-21 02:59:24", 3]
])
Debt.import([:id, :sub_category, :name, :created_at, :updated_at, :is_asset, :deleted_at, :fix_amount, :schedule, :payment_start_date, :autopay, :category_id, :account_id], [
  [1, "Credit Cards", "Amex", "2015-09-04 17:29:53", "2016-01-21 02:59:24", false, nil, nil, "Bi-Weekly", nil, false, 5, 2],
  [2, "Student Loans", "WolffAcademy", "2015-09-04 17:29:54", "2016-01-21 02:59:24", false, nil, nil, "Bi-Weekly", nil, true, 4, 1],
  [4, "Car Loans", "Vw", "2015-10-15 16:46:51", "2016-01-21 02:59:24", false, nil, "186.19", "Bi-Weekly", "2015-09-11", true, 4, 2],
  [7, "Savings", "Emergency Fundings", "2015-11-26 21:38:19", "2016-01-21 02:59:24", true, nil, nil, nil, nil, false, 6, 2],
  [8, "Rent", "Avalon", "2015-11-27 21:02:29", "2016-01-21 02:59:24", false, nil, "1550.0", "Monthly", nil, false, 7, 2],
  [9, "Phone", "Sams Phone", "2015-12-05 18:39:57", "2016-01-21 02:59:24", false, nil, nil, "Bi-Weekly", nil, false, 4, 2],
  [12, "Test", "Test", "2015-12-25 08:29:01", "2016-01-21 02:59:24", false, nil, nil, "Bi-Weekly", nil, true, 10, 5],
  [13, "Test", "City", "2015-12-25 09:27:52", "2016-01-21 02:59:24", false, nil, nil, "Bi-Weekly", nil, false, 11, 5]
])
DebtBalance.import([:id, :debt_id, :due_date, :balance, :created_at, :updated_at, :payment_start_date, :target_balance], [
  [1, 1, "2015-09-15", "1000.0", "2015-09-04 18:39:29", "2016-01-21 02:59:24", "2015-08-16", "0.0"],
  [2, 2, "2019-01-01", "4400.0", "2015-09-04 19:14:36", "2016-01-21 02:59:24", "2015-04-01", "0.0"],
  [3, 1, "2015-08-15", "500.0", "2015-09-04 19:16:17", "2016-01-21 02:59:24", "2015-07-16", "0.0"],
  [4, 1, "2015-10-15", "1000.0", "2015-09-04 19:19:29", "2016-01-21 02:59:24", "2015-09-16", "0.0"],
  [5, 1, "2015-11-15", "500.0", "2015-09-04 19:19:53", "2016-01-21 02:59:24", "2015-10-16", "0.0"],
  [6, 1, "2015-01-15", "3020.12", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2014-12-16", "0.0"],
  [7, 1, "2015-02-15", "2021.96", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-01-16", "0.0"],
  [8, 1, "2015-03-15", "2156.72", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-02-16", "0.0"],
  [9, 1, "2015-04-15", "2524.68", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-03-16", "0.0"],
  [10, 1, "2015-05-15", "2779.96", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-04-16", "0.0"],
  [11, 1, "2015-06-15", "3447.21", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-05-16", "0.0"],
  [12, 1, "2015-07-15", "3852.46", "2015-09-04 21:12:17", "2016-01-21 02:59:24", "2015-06-16", "0.0"],
  [13, 4, "2018-12-01", "14000.0", "2015-10-15 16:58:27", "2016-01-21 02:59:24", "2014-06-01", "0.0"],
  [14, 8, "2017-02-01", "26350.0", "2015-11-27 21:06:13", "2016-01-21 02:59:24", "2015-10-01", "0.0"],
  [15, 1, "2015-12-15", "4325.0", "2015-12-06 02:30:15", "2016-01-21 02:59:24", "2015-11-16", "0.0"],
  [16, 12, "2016-12-31", "1000.0", "2015-12-25 08:55:43", "2016-01-21 02:59:24", "2015-01-01", "0.0"],
  [17, 13, "2015-12-29", "2345.0", "2015-12-25 09:28:33", "2016-01-21 02:59:24", "2015-11-30", "0.0"]
])
AccountBalance.import([:id, :balance_date, :account_id, :amount, :buffer, :debt_id, :paid, :created_at, :updated_at, :debt_balance_id], [
  [3, "2015-10-30", 2, "2103.0", "10.0", 1, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 5],
  [4, "2015-10-16", 2, "1864.0", "10.0", 1, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 5],
  [5, "2015-11-06", 2, "1085.0", "10.0", 1, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 5],
  [6, "2015-10-23", 2, "436.0", "10.0", 1, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 5],
  [7, "2015-12-04", 2, "4934.0", "10.0", 2, true, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 2],
  [8, "2015-12-04", 1, "2000.0", "10.0", 2, true, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 2],
  [9, "2015-11-28", 1, "1010.0", "10.0", 2, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 2],
  [10, "2015-10-16", 1, "710.0", "10.0", 2, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 2],
  [11, "2015-11-06", 1, "80.0", "10.0", 2, false, "2015-12-19 21:44:56", "2016-01-21 02:59:24", 2],
  [18, "2015-12-31", 2, "2130.0", "10.0", 13, false, "2015-12-23 05:38:55", "2016-01-21 02:59:24", 16],
  [19, "2016-01-01", 5, "1250.0", "10.0", 12, false, "2015-12-25 09:03:00", "2016-01-21 02:59:24", 16],
  [20, "2016-01-01", 1, "3524.0", "10.0", 1, false, "2015-12-26 06:10:12", "2016-01-21 02:59:24", 2]
])
Budget.import([:id, :category_id, :budget_month, :amount, :created_at, :updated_at], [
  [1, 1, "2015-06-01", "508.47", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [2, 2, "2015-06-01", "120.96", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [3, 3, "2015-06-01", "21.33", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [4, 4, "2015-06-01", "271.92", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [5, 5, "2015-06-01", "87.8", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [6, 1, "2015-07-01", "489.44", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [7, 2, "2015-07-01", "103.14", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [8, 3, "2015-07-01", "168.02", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [9, 4, "2015-07-01", "272.79", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [10, 5, "2015-07-01", "191.83", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [11, 1, "2015-08-01", "391.66", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [12, 2, "2015-08-01", "153.62", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [13, 3, "2015-08-01", "184.22", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [14, 4, "2015-08-01", "262.43", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [15, 5, "2015-08-01", "150.1", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [16, 1, "2015-09-01", "339.62", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [17, 2, "2015-09-01", "136.04", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [18, 3, "2015-09-01", "193.34", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [19, 4, "2015-09-01", "277.6", "2015-09-04 13:30:57", "2016-01-21 02:59:24"],
  [20, 5, "2015-09-01", "152.07", "2015-09-04 13:30:57", "2016-01-21 02:59:24"]
])
IncomeSource.import([:id, :name, :pay_schedule, :pay_day, :amount, :start_date, :end_date, :created_at, :updated_at, :account_id], [
  [2, "Job 2", "semi-monthly", "15, last", "100.0", "2015-10-01", "2015-12-31", "2015-12-13 22:10:29", "2016-01-21 02:59:24", 1],
  [3, "Job 1", "weekly", "thursday", "100.0", "2015-01-01", "2015-12-31", "2015-12-14 00:41:21", "2016-01-21 02:59:24", 1],
  [4, "Job 3b", "weekly", "friday", "150.0", "2015-12-04", "2016-01-01", "2015-12-25 07:01:55", "2016-01-21 02:59:24", 5]
])
PaymentMethod.import([:id, :name, :description, :created_at, :updated_at, :user_id], [
  [1, "Credit", "Any of our cc", "2015-09-04 17:29:53", "2016-01-21 02:59:24", 2],
  [2, "Debit", "Any of our debit", "2015-09-04 17:29:53", "2016-01-21 02:59:24", 2],
  [3, "Gift", "Any gift card", "2015-09-04 17:29:53", "2016-01-21 02:59:24", 2],
  [4, "Cash", "Cash", "2015-09-04 17:29:53", "2016-01-21 02:59:24", 2],
  [5, "Other", "Any other form of payments", "2015-09-04 17:29:53", "2016-01-21 02:59:24", 2],
  [6, "Credit", "All Credit purchases", "2015-12-25 05:47:53", "2016-01-21 02:59:24", 3],
  [7, "Paypal", "Must have a payment method", "2016-01-20 16:30:02", "2016-01-21 02:59:24", 2]
])
Spending.import([:id, :description, :spending_date, :amount, :created_at, :updated_at, :budget_id, :payment_method_id, :debt_balance_id], [
  [1, "WolffAcademy", "2015-06-08", "92.44", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 4, 2, 2],
  [3, "Amex", "2015-06-12", "92.2", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 5, 2, 11],
  [4, "Gorgeous Concrete Clock", "2015-09-08", "32.32", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 18, 2, nil],
  [6, "Amex", "2015-09-25", "22.6", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 20, 2, 4],
  [7, "Amex", "2015-06-23", "23.95", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 5, 2, 12],
  [8, "Practical Granite Coat", "2015-09-24", "54.61", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 16, 4, nil],
  [10, "Enormous Bronze Shoes", "2015-09-03", "15.41", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 16, 3, nil],
  [11, "Amex", "2015-06-25", "85.88", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 5, 2, 12],
  [12, "WolffAcademy", "2015-06-16", "83.51", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 4, 2, 2],
  [13, "Gorgeous Steel Table", "2015-07-14", "80.56", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 7, 3, nil],
  [14, "Synergistic Rubber Coat", "2015-07-08", "60.65", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 6, 2, nil],
  [15, "Heavy Duty Plastic Plate", "2015-09-19", "94.74", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 17, 4, nil],
  [16, "Incredible Leather Clock", "2015-06-25", "9.72", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 3, 4, nil],
  [17, "Awesome Plastic Plate", "2015-08-13", "56.06", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 11, 2, nil],
  [18, "WolffAcademy", "2015-08-31", "74.84", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 14, 2, 2],
  [19, "WolffAcademy", "2015-07-13", "32.98", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 9, 2, 2],
  [20, "WolffAcademy", "2015-07-09", "56.34", "2015-09-04 17:29:54", "2016-01-21 02:59:24", 9, 2, 2]
], validate: false)
User::HABTM_Contributors.import([:user_id, :contributor_user_id], [
  [3, 2],
  [2, 3]
])
