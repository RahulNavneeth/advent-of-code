defmodule Main do
  def read_input() do
    case File.read("../input.in") do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          [first, second] = String.split(line, " ")
          {String.to_integer(first), String.to_integer(second)}
        end)
        |> Enum.unzip()
        |> then(fn {a, b} ->
          {:ok, {Enum.sort(a), Enum.sort(b)}}
        end)

      {:error, reason} ->
        IO.puts("Can't read the file input.in: #{reason}")
        {:error, reason}
    end
  end

  def main_part_one() do
    case read_input() do
      {:ok, {a, b}} ->
        sum =
          Enum.zip(a, b)
          |> Enum.map(fn {x, y} -> abs(x - y) end)
          |> Enum.sum()

        IO.puts("Answer for part two : #{sum}")

      {:error, _reason} ->
        IO.puts("Program terminated due to file error.")
    end
  end

  def main_part_two() do
    case read_input() do
      {:ok, {a, b}} ->
        sum =
          Enum.map(a, fn i ->
            i * Enum.count(b, fn j -> i == j end)
          end)
          |> Enum.sum()

        IO.puts("Answer for part one : #{sum}")

      {:error, _reason} ->
        IO.puts("Program terminated due to file error.")
    end
  end
end

Main.main_part_one()
Main.main_part_two()
