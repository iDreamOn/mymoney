module ApplicationHelper
  VALID = %w(Amex Freedom Travel Cash Jcp Express).freeze
  VALID_GOOD_NEG = ['Credit Cards', 'Savings', 'Loans'].freeze
  ERROR = '#FF0000'.freeze
  NEUTRAL = '#FFFFFF'.freeze
  SUCCESS = '#0000FF'.freeze
  LIGHT_SUCCESS = '#00CCFF'.freeze
  WARNING = '#DEDE0C'.freeze

  def sort_column
    params[:order].nil? ? 'id' : params[:order]
  end

  def sort_direction
    %w(asc desc).include?(params[:sort_mode]) ? params[:sort_mode] : 'desc'
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'My Money'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # this is one way to define new instance methods
  ActionView::Helpers::FormBuilder.class_eval do
    def calendar_field(method, options = {})
      text_field(method, options.merge(class: 'datepicker'))
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil), class: css_class
  end

  def good_pos_cell_color(amount = 0, debt_name = '')
    if VALID_GOOD_NEG.include?(debt_name)
      good_neg_cell_color(amount)
    else
      amount < 0 ? ERROR : NEUTRAL
    end
  end

  def good_pos_cell_color_comparison(base = 0, actual = 0, debt_name = '')
    if VALID_GOOD_NEG.include?(debt_name)
      good_pos_cell_color_comparison(actual, base)
    else
      diff = actual / base - 1
      if diff <= 0
        SUCCESS
      elsif diff <= 0.10
        WARNING
      else
        ERROR
      end
    end
  end

  def good_neg_cell_color(amount = 0, debt_name = nil, success = nil)
    debt = Debt.find_by_name(debt_name)

    if !debt.nil?
      amount > 0 && VALID.include?(debt.name) ? ERROR : NEUTRAL
    elsif success
      amount > 0 ? ERROR : SUCCESS
    else
      NEUTRAL
    end
  end

  def equal_cell_color(amount_1 = nil, amount_2 = nil, alert = true)
    return if amount_1.nil? || amount_2.nil?
    if amount_1 == amount_2
      alert ? SUCCESS : NEUTRAL
    else
      ERROR
    end
  end

  def success(is_success = false)
    is_success ? LIGHT_SUCCESS : NEUTRAL
  end

  Struct.new('GroupedItemsForSelect', :name, :items)
  def get_grouped(list)
    list.group_by(&:owner).map { |owner, models| Struct::GroupedItemsForSelect.new(owner.first_name, models) }
  end

  def plural(model)
    model.model_name.human(count: 2).titleize
  end

  def singular(model)
    model.model_name.human.titleize
  end

  def genderize(model, gender)
    t("new.#{gender}", item: singular(model)).titleize
  end
end
