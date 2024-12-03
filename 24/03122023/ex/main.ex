defmodule Main do
  def read_input() do
    case File.read("../input.in") do
      {:ok, content} ->
        {:ok, content}

      {:error, reason} ->
        IO.puts("Can't read the file input.in: #{reason}")
        {:error, reason}
    end
  end

  def main_part_one() do
    case read_input() do
      {:ok, content} ->
        Regex.scan(~r/(mul\(\d+,\d+\))/, content)
        |> Enum.map(&List.first/1)
        |> Enum.map(fn x ->
          Regex.scan(~r/\d+/, x)
          |> Enum.map(fn y -> List.first(y) |> String.to_integer() end)
          |> Enum.reduce(1, fn a, v -> v * a end)
        end)
        |> Enum.sum()
        |> (&IO.puts("Answer for part one: #{&1}")).()

      :error ->
        IO.puts("Invalid output")
    end
  end

  def main_part_two() do
    case read_input() do
      {:ok, content} ->
        Regex.scan(~r/(mul\(\d+,\d+\))|don\'t\(\)|do\(\)/, content)
        |> Enum.map(&List.first/1)
        |> Enum.map(fn x ->
          case String.match?(x, ~r/mul/) do
            true ->
              Regex.scan(~r/\d+/, x)
              |> Enum.map(fn y -> List.first(y) |> String.to_integer() end)
              |> Enum.reduce(1, fn a, v -> v * a end)

            false ->
              x
          end
        end)
        |> Enum.reduce({0, true}, fn x, {ans, state} ->
          case x do
            "don\'t\(\)" -> {ans, false}
            "do\(\)" -> {ans, true}
            _ -> if state, do: {ans + x, state}, else: {ans, state}
          end
        end)
        |> elem(0)
        |> (&IO.puts("Answer for part two: #{&1}")).()

      :error ->
        IO.puts("Invalid output")
    end
  end
end

Main.main_part_one()
Main.main_part_two()
