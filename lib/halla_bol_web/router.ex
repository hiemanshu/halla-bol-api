defmodule HallaBolWeb.Router do
  use HallaBolWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HallaBolWeb do
    pipe_through :api
  end
end
