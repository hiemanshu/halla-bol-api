defmodule HallaBolWeb.Router do
  use HallaBolWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HallaBolWeb do
    pipe_through :api
    resources "/campaigns", CampaignController, except: [:new, :edit], param: "slug"
  end
end
