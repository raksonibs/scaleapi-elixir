defmodule Scale do
  @moduledoc """
  Documentation for Scale.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Scale.hello
      :world

  """
  def scale do
    api_key = ""
    callback_key = ""

    body = %{
      callback_url: "url",
      instruction: "Draw a tight polygon around every **car** in the image.",
      attachment_type: "image",
      attachment:
        "",
      objects_to_annotate: "car",
      with_labels: true
    }

    url = "https://api.scaleapi.com/v1/task/polygonannotation"

    options = [
      [hackney: [basic_auth: {"#{api_key}", ""}]],
      headers: [
        Authorization: "Basic #{api_key}"
      ],
      body: Poison.encode!(body)
    ] ++ ssl_options(url)

    case HTTPotion.request(:post, url, options) do
      {:ok, response} ->
        {:ok, Jason.decode!(response.body)}

      %HTTPotion.ErrorResponse{message: msg} ->
        {:error, msg}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def ssl_options(url) do
    {:ok, {scheme, _, host, _, _, _}} = :http_uri.parse(url |> to_charlist)
    is_ssl = (scheme == :https)
    is_hostname =  :http_util.is_hostname(host)
    cond do is_ssl and is_hostname -> [ssl: true, server_name_indication: host]
      is_ssl -> [ssl: true]
      true -> []
    end
  end
end
