defmodule Trial.Warehouse do
  @moduledoc """
  The Warehouse context.
  """

  import Ecto.Query, warn: false
  alias Trial.Repo

  alias Trial.Warehouse.Warehouse_id

  @doc """
  Returns the list of warehouse_id.

  ## Examples

      iex> list_warehouse_id()
      [%Warehouse_id{}, ...]

  """
  def list_warehouse_id do
    Repo.all(Warehouse_id)
  end

  @doc """
  Gets a single warehouse_id.

  Raises `Ecto.NoResultsError` if the Warehouse does not exist.

  ## Examples

      iex> get_warehouse_id!(123)
      %Warehouse_id{}

      iex> get_warehouse_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warehouse_id!(id), do: Repo.get!(Warehouse_id, id)

  @doc """
  Creates a warehouse_id.

  ## Examples

      iex> create_warehouse_id(%{field: value})
      {:ok, %Warehouse_id{}}

      iex> create_warehouse_id(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warehouse_id(attrs \\ %{}) do
    %Warehouse_id{}
    |> Warehouse_id.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warehouse_id.

  ## Examples

      iex> update_warehouse_id(warehouse_id, %{field: new_value})
      {:ok, %Warehouse_id{}}

      iex> update_warehouse_id(warehouse_id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warehouse_id(%Warehouse_id{} = warehouse_id, attrs) do
    warehouse_id
    |> Warehouse_id.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a warehouse_id.

  ## Examples

      iex> delete_warehouse_id(warehouse_id)
      {:ok, %Warehouse_id{}}

      iex> delete_warehouse_id(warehouse_id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warehouse_id(%Warehouse_id{} = warehouse_id) do
    Repo.delete(warehouse_id)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warehouse_id changes.

  ## Examples

      iex> change_warehouse_id(warehouse_id)
      %Ecto.Changeset{data: %Warehouse_id{}}

  """
  def change_warehouse_id(%Warehouse_id{} = warehouse_id, attrs \\ %{}) do
    Warehouse_id.changeset(warehouse_id, attrs)
  end

  alias Trial.Warehouse.Warehouse_id_name

  @doc """
  Returns the list of warehouse_id_name.

  ## Examples

      iex> list_warehouse_id_name()
      [%Warehouse_id_name{}, ...]

  """
  def list_warehouse_id_name do
    Repo.all(Warehouse_id_name)
  end

  @doc """
  Gets a single warehouse_id_name.

  Raises `Ecto.NoResultsError` if the Warehouse id name does not exist.

  ## Examples

      iex> get_warehouse_id_name!(123)
      %Warehouse_id_name{}

      iex> get_warehouse_id_name!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warehouse_id_name!(id), do: Repo.get!(Warehouse_id_name, id)

  @doc """
  Creates a warehouse_id_name.

  ## Examples

      iex> create_warehouse_id_name(%{field: value})
      {:ok, %Warehouse_id_name{}}

      iex> create_warehouse_id_name(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warehouse_id_name(attrs \\ %{}) do
    %Warehouse_id_name{}
    |> Warehouse_id_name.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warehouse_id_name.

  ## Examples

      iex> update_warehouse_id_name(warehouse_id_name, %{field: new_value})
      {:ok, %Warehouse_id_name{}}

      iex> update_warehouse_id_name(warehouse_id_name, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warehouse_id_name(%Warehouse_id_name{} = warehouse_id_name, attrs) do
    warehouse_id_name
    |> Warehouse_id_name.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a warehouse_id_name.

  ## Examples

      iex> delete_warehouse_id_name(warehouse_id_name)
      {:ok, %Warehouse_id_name{}}

      iex> delete_warehouse_id_name(warehouse_id_name)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warehouse_id_name(%Warehouse_id_name{} = warehouse_id_name) do
    Repo.delete(warehouse_id_name)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warehouse_id_name changes.

  ## Examples

      iex> change_warehouse_id_name(warehouse_id_name)
      %Ecto.Changeset{data: %Warehouse_id_name{}}

  """
  def change_warehouse_id_name(%Warehouse_id_name{} = warehouse_id_name, attrs \\ %{}) do
    Warehouse_id_name.changeset(warehouse_id_name, attrs)
  end

  def list_warehouse_id_name_joined do
    from(warehouse in Warehouse_id_name)
    |> join(:left, [warehouse], warehouse_id in Warehouse_id, on: warehouse.warehouse_id == warehouse_id.id)
    |> select([warehouse, warehouse_id], {warehouse_id.warehouse_id, warehouse.warehouse_id_name, warehouse.id, warehouse_id.id})
    |> Repo.all()
  end

  def list_warehouse_id_not_used do
    query = from warehouse_id in Warehouse_id,
      left_join: warehouse_id_name in Warehouse_id_name,
      on: warehouse_id.id == warehouse_id_name.warehouse_id,
      where: is_nil(warehouse_id_name.warehouse_id),
      select: {warehouse_id.id, warehouse_id.warehouse_id}

    Repo.all(query)
  end
end
