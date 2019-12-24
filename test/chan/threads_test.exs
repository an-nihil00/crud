defmodule Chan.ThreadsTest do
  use Chan.DataCase

  alias Chan.Threads

  describe "threads" do
    alias Chan.Threads.Thread

    @valid_attrs %{op: 42, replies: [], subject: "some subject"}
    @update_attrs %{op: 43, replies: [], subject: "some updated subject"}
    @invalid_attrs %{op: nil, replies: nil, subject: nil}

    def thread_fixture(attrs \\ %{}) do
      {:ok, thread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Threads.create_thread()

      thread
    end

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Threads.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      assert {:ok, %Thread{} = thread} = Threads.create_thread(@valid_attrs)
      assert thread.op == 42
      assert thread.replies == []
      assert thread.subject == "some subject"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, @update_attrs)
      assert thread.op == 43
      assert thread.replies == []
      assert thread.subject == "some updated subject"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end

  describe "threads" do
    alias Chan.Threads.Thread

    @valid_attrs %{board: "some board", op: 42, replies: [], subject: "some subject"}
    @update_attrs %{board: "some updated board", op: 43, replies: [], subject: "some updated subject"}
    @invalid_attrs %{board: nil, op: nil, replies: nil, subject: nil}

    def thread_fixture(attrs \\ %{}) do
      {:ok, thread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Threads.create_thread()

      thread
    end

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Threads.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      assert {:ok, %Thread{} = thread} = Threads.create_thread(@valid_attrs)
      assert thread.board == "some board"
      assert thread.op == 42
      assert thread.replies == []
      assert thread.subject == "some subject"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, @update_attrs)
      assert thread.board == "some updated board"
      assert thread.op == 43
      assert thread.replies == []
      assert thread.subject == "some updated subject"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end

  describe "boards" do
    alias Chan.Threads.Thread

    @valid_attrs %{subject: "some subject"}
    @update_attrs %{subject: "some updated subject"}
    @invalid_attrs %{subject: nil}

    def thread_fixture(attrs \\ %{}) do
      {:ok, thread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Threads.create_thread()

      thread
    end

    test "list_boards/0 returns all boards" do
      thread = thread_fixture()
      assert Threads.list_boards() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      assert {:ok, %Thread{} = thread} = Threads.create_thread(@valid_attrs)
      assert thread.subject == "some subject"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, @update_attrs)
      assert thread.subject == "some updated subject"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end

  describe "threads" do
    alias Chan.Threads.Thread

    @valid_attrs %{subject: "some subject"}
    @update_attrs %{subject: "some updated subject"}
    @invalid_attrs %{subject: nil}

    def thread_fixture(attrs \\ %{}) do
      {:ok, thread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Threads.create_thread()

      thread
    end

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Threads.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      assert {:ok, %Thread{} = thread} = Threads.create_thread(@valid_attrs)
      assert thread.subject == "some subject"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, @update_attrs)
      assert thread.subject == "some updated subject"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end
end
