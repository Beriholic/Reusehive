import { $http } from "./index";

export const getAllItemsApi = () => {
  return $http({
    method: "get",
    url: "http://127.0.0.1:4523/m1/4280410-0-default/item/all",
  });
};

export const getItemByItemIdApi = (data: { id: string }) => {
  const url = "http://127.0.0.1:4523/m1/4280410-0-default/item/" + data.id;
  return $http({
    method: "get",
    url: url,
  });
};

export const newItemApi = (data: {
  name: String;
  description: String;
  prices: String;
  itemType: String;
  images: Array<any>;
}) => {
  var formData = new FormData();
  for (let i = 0; i < data.images.length; i++) {
    formData.append("images", data.images[i].raw);
  }

  formData.append("name", data.name.toString());
  formData.append("description", data.description.toString());
  formData.append("prices", data.prices.toString());
  formData.append("itemType", data.itemType.toString());

  return $http({
    data: formData,
    method: "post",
    url: "http://127.0.0.1:8888/item/new",
  });
};
