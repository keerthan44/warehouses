defmodule TrialWeb.Router do
  use TrialWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TrialWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrialWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/add_ids", HelloController, :index
  end

  scope "/live", TrialWeb do
    pipe_through :browser

    live "/", PageLive
    live "/add_ids", HelloLive
  end

  scope "/api", TrialWeb do
    pipe_through :api

    resources "/warehouse_id", Warehouse_idController, except: [:new, :edit]
    resources "/warehouse_id_name", Warehouse_id_nameController, except: [:new, :edit, :delete]

    post "/warehouse_id_name/delete", Warehouse_id_nameController, :delete
    get "/warehouse_id_not_used/", Warehouse_idController, :show_not_used
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrialWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:trial, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TrialWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
