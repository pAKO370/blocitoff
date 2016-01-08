class ItemPolicy
  attr_reader :current_user, :item

  def initialize(current_user, item)
    @current_user = current_user
    @item = item
  end

  def index?
    current_user
  end

  def show?
    item.user == current_user 
  end

  def create?
    item.user == current_user
  end

  def new?
    create?
  end

  def update?
    item.user == current_user
  end

  def edit?
    update?
  end

  def destroy?
    item.user == current_user
  end

  def destroy_multiple?
    items = item  # actually contains a collection
    items.all?{ |item| item.user == current_user }
  end
end
