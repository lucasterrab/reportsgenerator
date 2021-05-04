# ReportsGenerator

A program that reads a csv file containing information [id, food, price] and generates a report containing what each user [id] bought [food] and how much he spent [price]. It is also able to tell which food was the most ordered and which user spent the most.

**Example**

With no parallelism

```elixir

iex(1)> :timer.tc(fn -> ReportsGenerator.build("report_complete.csv") end)
{774182,
 %{
   "foods" => %{
     "açaí" => 37742,
     "churrasco" => 37650,
     "esfirra" => 37462,
     "hambúrguer" => 37577,
     "pastel" => 37392,
     "pizza" => 37365,
     "prato_feito" => 37519,
     "sushi" => 37293
   },
   "users" => %{
     "1" => 278849,
     "10" => 268317,
     "11" => 268877,
     "12" => 276306,
     "13" => 282953,
     "14" => 277084,
     "15" => 280105,
     "16" => 271831,
     "17" => 272883,
     "18" => 271421,
     "19" => 277720,
     "2" => 271031,
     "20" => 273446,
     "21" => 275026,
     "22" => 278025,
     "23" => 276523,
     "24" => 274481,
     "25" => 274512,
     "26" => 274199,
     "27" => 278001,
     "28" => 274256,
     "29" => 273030,
     "3" => 272250,
     "30" => 275978,
     "4" => 277054,
     "5" => 270926,
     "6" => 272053,
     "7" => 273112,
     "8" => 275161,
     "9" => 274003
   }
 }}

```

With parallelism

```elixir
iex(2)> :timer.tc(fn -> ReportsGenerator.build_from_many(["report_1.csv", "report_2.csv", "report_3.csv"]) end)
{234538,
 %{
   "foods" => %{
     "açaí" => 37742,
     "churrasco" => 37650,
     "esfirra" => 37462,
     "hambúrguer" => 37577,
     "pastel" => 37392,
     "pizza" => 37365,
     "prato_feito" => 37519,
     "sushi" => 37293
   },
   "users" => %{
     "1" => 278849,
     "10" => 268317,
     "11" => 268877,
     "12" => 276306,
     "13" => 282953,
     "14" => 277084,
     "15" => 280105,
     "16" => 271831,
     "17" => 272883,
     "18" => 271421,
     "19" => 277720,
     "2" => 271031,
     "20" => 273446,
     "21" => 275026,
     "22" => 278025,
     "23" => 276523,
     "24" => 274481,
     "25" => 274512,
     "26" => 274199,
     "27" => 278001,
     "28" => 274256,
     "29" => 273030,
     "3" => 272250,
     "30" => 275978,
     "4" => 277054,
     "5" => 270926,
     "6" => 272053,
     "7" => 273112,
     "8" => 275161,
     "9" => 274003
   }
 }}
```