class RepositoriesController < ApplicationController


  # Define name for the person you are searching for

  IndexQuery = GitHub::Client.parse <<-'GRAPHQL'
    query($nom: String!){
      search(query: $nom, type: USER, first: 1) {
        nodes{
          ...Views::Repositories::Index::User
        }
      }
    }
  GRAPHQL

  # GET /repositories
  def index
    if params[:name].blank?
      redirect_to(root_path, alert: "Empty name!") and return
    else
      @@name = params[:name]
    end
    # `query` returns a GraphQL::Client::QueryResult instance with accessors
    # that map to the query structure.
    data = query IndexQuery, nom: @@name
    # Render the app/views/repositories/index.html.erb template with our
    # current User.
    #
    #Testing if user is found
    if data.search.nodes[0].equal? nil
      redirect_to(search_page_path, "error" => "Empty name!") and return
    end
    # Using explicit render calls with locals is preferred to implicit render
    # with instance variables.

    render "repositories/index", locals: {
      user: data.search.nodes[0]
    }
  end


  # Define query for "Show more repositories..." AJAX action.
  MoreQuery = GitHub::Client.parse <<-'GRAPHQL'
    # This query uses variables to accept an "after" param to load the next
    # 10 repositories.
    query($nom: String!, $after: String!) {
      search(query: $nom, type: USER, first: 1) {
        nodes{
         ...on User{
           repositories(first: 10, after: $after) {
             # Instead of refetching all of the index page's data, we only need
             # the data for the repositories container partial.
             ...Views::Repositories::Repositories::RepositoryConnection
           }
          }
        }
      }
    }
  GRAPHQL

  # GET /repositories/more?after=CURSOR
  def more
    # Execute the MoreQuery passing along data from params to the query.
    data = query MoreQuery, after: params[:after], nom: @@name

    # Using an explicit render again, just render the repositories list partial
    # and return it to the client.
    render partial: "repositories/repositories", locals: {
      repositories: data.search.nodes[0].repositories
    }
  end


  # Define query for repository show page.
  ShowQuery = GitHub::Client.parse <<-'GRAPHQL'
    # Query is parameterized by a $id variable.
    query($id: ID!) {
      # Use global id Node lookup
      node(id: $id) {
        # Include fragment for app/views/repositories/show.html.erb
        ...Views::Repositories::Show::Repository
      }
    }
  GRAPHQL

  # GET /repositories/ID
  def show
    data = query ShowQuery, id: params[:id]

    if repository = data.node
      render "repositories/show", locals: {
        repository: repository
      }
    else
      # If node can't be found, 404. This may happen if the repository doesn't
      # exist, we don't have permission or we used a global ID that was the
      # wrong type.
      head :not_found
    end
  end

  LanguagesQuery = GitHub::Client.parse <<-'GRAPHQL'
    # This query uses variables to accept an "after" param to load the next
    # 10 repositories.
    query($nom: String!, $after: String!) {
      search(query: $nom, type: USER, first: 1) {
        nodes{
         ...on User{
           repositories(first: 10, after: $after) {
             # Instead of refetching all of the index page's data, we only need
             # the data for the repositories container partial.
             ...Views::Repositories::Repositories::RepositoryConnection
           }
          }
        }
      }
    }
  GRAPHQL

end
