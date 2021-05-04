defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options ["foods", "users"]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def build_from_many(filenames) do
    filenames
    |> Task.async_stream(&build/1)
    |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)
  end

  def fetch_higher_cost(report, option) when option in @options do
    Enum.max_by(report[option], fn {_key, value} -> value end)
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option!"}

  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    report
    |> Map.put("users", users)
    |> Map.put("foods", foods)

    # could also be done using %{reports | "users" => users, "foods" => foods}
  end

  defp sum_reports(%{"foods" => foods1, "users" => users1}, %{"foods" => foods2, "users" => users2}) do
    foods = merge_maps(foods1, foods2)
    users = merge_maps(users1, users2)

    build_report(foods, users)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp report_acc do
    foods = Enum.into(@available_foods, %{}, fn x -> {x, 0} end)
    users = Enum.into(1..30, %{}, fn x -> {Integer.to_string(x), 0} end)

    build_report(foods, users)
  end

  defp build_report(foods, users), do: %{"foods" => foods, "users" => users}
end
