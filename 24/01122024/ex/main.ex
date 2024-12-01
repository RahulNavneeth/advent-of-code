defmodule Main do
  def read_input() do
    case File.read("../input.in") do
      {:ok, content} ->
        {a, b} =
          content
          |> String.split("\n", trim: true)
          |> Enum.reduce({[], []}, fn line, {a, b} ->
            [first, second] = String.split(line, " ")
            {[String.to_integer(first) | a], [String.to_integer(second) | b]}
          end)

        {:ok, {Enum.sort(a), Enum.sort(b)}}

      {:error, reason} ->
        IO.puts("Can't read the file input.in: #{reason}")
        :error
    end
  end

  def main_part_one() do
    case read_input() do
      {:ok, {a, b}} ->
        sum =
          Enum.reduce(0..(length(a) - 1), [], fn index, arr ->
            [abs(Enum.at(a, index) - Enum.at(b, index)) | arr]
          end)
          |> Enum.sum()

        IO.puts(sum)

      :error ->
        IO.puts("Program terminated due to file error.")
    end
  end

  def main_part_two() do
    case read_input() do
      {:ok, {a, b}} ->
        sum =
          Enum.map(a, fn i ->
            i * (Enum.map(b, fn j -> if i == j, do: 1, else: 0 end) |> Enum.sum())
          end)
          |> Enum.sum()

        IO.puts(sum)

      :error ->
        IO.puts("Program terminated due to file error.")
    end
  end
end

# Main.main_part_one()
Main.main_part_two()
