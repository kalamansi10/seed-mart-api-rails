class Api::V1::ItemController < ApplicationController
    # GET /api/v1/item/search
    def search_items
      keyword = params[:keyword].downcase
      offset = params[:offset]

      # Filter items based on keyword and additional filters
      item_list = item_sorter(item_filter(price_filter(Item)))
                  .where("tags LIKE ?", "%#{keyword}%")

      render json: {
        item_list: item_list.limit(20)
                            .offset(offset)
                            .map { |item| item_details(item) },
        item_count: item_list.count
      }
    end

    # GET /api/v1/item/:item_id
    def get_item
      # Retrieve details of a specific item
      render json: Item.get(params[:item_id])
    end

    private

    # Sorts item list
    def item_sorter(item_list)
      case params[:sort_by]
      when nil
        return item_list.order(created_at: :desc)
      when "price-lowest"
        return item_list.order(price: :asc)
      when "price-highest"
        return item_list.order(price: :desc)
      end
    end

    # Apply additional filters to the item list
    def item_filter(item_list)
      return item_list if params[:filter].blank?

      params[:filter].each do |k, v|
        item_list = item_list.where(k => v)
      end

      item_list
    end

    # Apply price range filter to the item list
    def price_filter(item_list)
      item_list = item_list.where("price >= ?", params[:minimum]) unless params[:minimum].blank?
      item_list = item_list.where("price <= ?", params[:maximum]) unless params[:maximum].blank?
      item_list
    end

    # Extract details for each item
    def item_details(item)
      {
        id: item.id,
        name: item.name,
        price: item.price,
        preview_image: item.image_links[0],
        item_sold: item.orders.count
      }
    end
end
