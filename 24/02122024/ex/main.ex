defmodule Main do
  def read_input() do
    case File.read("../input.in") do
      {:ok, content} ->
        {:ok,
         content
         |> String.split("\n", trim: true)
         |> Enum.map(fn line ->
           String.split(line, " ") |> Enum.map(fn num -> String.to_integer(num) end)
         end)}

      {:error, reason} ->
        IO.puts("Can't read the file input.in: #{reason}")
        {:error, reason}
    end
  end

  def main_part_one() do
    case read_input() do
      {:ok, arr} ->
        sum =
          Enum.map(arr, fn subarray ->
            case subarray do
              [first, second | _] ->
                bool = first < second

                Enum.chunk_every(subarray, 2, 1, :discard)
                |> Enum.all?(fn [a, b] ->
                  abs(a - b) >= 1 and abs(a - b) <= 3 and bool == a < b
                end)

              _ ->
                false
            end
          end)
          |> Enum.count(& &1)

        IO.puts("Answer for part one: #{sum}")
    end
  end

  def main_part_two() do
    case read_input() do
      {:ok, arr} ->
        sum =
          Enum.map(arr, fn subarray ->
            subarray
            |> Enum.with_index()
            |> Enum.map(fn {_, idx} ->
              List.delete_at(subarray, idx)
            end)
            |> Enum.any?(fn subset ->
              case subset do
                [first, second | _] ->
                  bool = first < second

                  Enum.chunk_every(subset, 2, 1, :discard)
                  |> Enum.all?(fn [a, b] ->
                    abs(a - b) >= 1 and abs(a - b) <= 3 and bool == a < b
                  end)

                _ ->
                  false
              end
            end)
          end)
          |> Enum.count(& &1)

        IO.puts("Answer for part two: #{sum}")
    end
  end
end

Main.main_part_one()
Main.main_part_two()
