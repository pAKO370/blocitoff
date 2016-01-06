class ItemPolicy < ApplicationPolicy

attr_reader :current_user, :item

  def initialize(current_user, item)
    @current_user = current_user
    @item = item
  end

  def index?
    current_user
  end

  def show?
    @user == current_user 
  end

  def create?
    current_user
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end

