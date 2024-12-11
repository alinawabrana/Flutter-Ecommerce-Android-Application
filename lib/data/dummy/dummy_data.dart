import 'package:e_commerce_app/features/shop/models/banner_model.dart';
import 'package:e_commerce_app/features/shop/models/brand_category_model.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/models/product_attribute_model.dart';
import 'package:e_commerce_app/features/shop/models/product_category_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/models/product_variation_model.dart';
import 'package:e_commerce_app/routes/routes.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';

class TDummyData {
  /// -- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(
        imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(
        imageUrl: TImages.banner3,
        targetScreen: TRoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(
        imageUrl: TImages.banner5,
        targetScreen: TRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: TImages.banner6,
        targetScreen: TRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: TImages.banner8,
        targetScreen: TRoutes.checkout,
        active: false),
  ];

  /// -- User

  /// -- Cart

  /// -- Order

  /// -- List of all categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: TImages.sportIcon, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '5',
        image: TImages.furnitureIcon,
        name: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '2',
        image: TImages.electronicsIcon,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: TImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', image: TImages.animalIcon, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '6', image: TImages.shoeIcon, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: TImages.cosmeticsIcon,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '17',
        image: TImages.jeweleryIcon,
        name: 'Jewelery',
        isFeatured: true),

    /// subcategories

    // sports
    CategoryModel(
        id: '8',
        image: TImages.sportIcon,
        name: 'Sport Shoes',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        image: TImages.sportIcon,
        name: 'Track suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        image: TImages.sportIcon,
        name: 'Sports Equipments',
        parentId: '1',
        isFeatured: false),

    // furniture
    CategoryModel(
        id: '11',
        image: TImages.furnitureIcon,
        name: 'Bedroom furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        image: TImages.furnitureIcon,
        name: 'Kitchen furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: TImages.furnitureIcon,
        name: 'Office furniture',
        parentId: '5',
        isFeatured: false),

    // electronics
    CategoryModel(
        id: '14',
        image: TImages.electronicsIcon,
        name: 'Laptop',
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '15',
        image: TImages.electronicsIcon,
        name: 'Mobile',
        parentId: '2',
        isFeatured: false),

    // clothes
    CategoryModel(
        id: '16',
        image: TImages.clothIcon,
        name: 'Shirts',
        parentId: '3',
        isFeatured: false),
  ];

  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        name: 'Nike',
        image: TImages.nikeLogo,
        productsCount: 256,
        isFeatured: true),
    BrandModel(
        id: '10',
        name: 'Acer',
        image: TImages.acerlogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: '2',
        name: 'Adidas',
        image: TImages.adidasLogo,
        productsCount: 95,
        isFeatured: true),
    BrandModel(
        id: '3',
        name: 'Jordan',
        image: TImages.jordanLogo,
        productsCount: 36,
        isFeatured: true),
    BrandModel(
        id: '4',
        name: 'Puma',
        image: TImages.pumaLogo,
        productsCount: 65,
        isFeatured: true),
    BrandModel(
        id: '5',
        name: 'Apple',
        image: TImages.appleLogo,
        productsCount: 16,
        isFeatured: false),
    BrandModel(
        id: '6',
        name: 'Zara',
        image: TImages.zaraLogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: '7',
        name: 'Samsung',
        image: TImages.hermanMillerLogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: '8',
        name: 'Kenwood',
        image: TImages.kenwoodLogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: '9',
        name: 'IKEA',
        image: TImages.ikeaLogo,
        productsCount: 36,
        isFeatured: false),
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '2', categoryId: '1'),
    BrandCategoryModel(brandId: '3', categoryId: '1'),
    BrandCategoryModel(brandId: '4', categoryId: '1'),
    BrandCategoryModel(brandId: '5', categoryId: '2'),
    BrandCategoryModel(brandId: '7', categoryId: '2'),
    BrandCategoryModel(brandId: '6', categoryId: '3'),
    BrandCategoryModel(brandId: '9', categoryId: '4'),
    BrandCategoryModel(brandId: '8', categoryId: '5'),
    BrandCategoryModel(brandId: '1', categoryId: '6'),
    BrandCategoryModel(brandId: '2', categoryId: '6'),
    BrandCategoryModel(brandId: '3', categoryId: '6'),
    BrandCategoryModel(brandId: '4', categoryId: '6'),
    BrandCategoryModel(brandId: '10', categoryId: '6'),
    BrandCategoryModel(brandId: '8', categoryId: '7'),
    BrandCategoryModel(brandId: '9', categoryId: '7'),
    BrandCategoryModel(brandId: '9', categoryId: '17'),
  ];

  static final List<ProductCategoryModel> productCategory = [
    ProductCategoryModel(categoryId: '1', productId: '001'),
    ProductCategoryModel(categoryId: '1', productId: '005'),
    ProductCategoryModel(categoryId: '1', productId: '009'),
    ProductCategoryModel(categoryId: '2', productId: '006'),
    ProductCategoryModel(categoryId: '2', productId: '007'),
    ProductCategoryModel(categoryId: '3', productId: '002'),
    ProductCategoryModel(categoryId: '3', productId: '003'),
    ProductCategoryModel(categoryId: '3', productId: '004'),
    ProductCategoryModel(categoryId: '4', productId: '007'),
    ProductCategoryModel(categoryId: '5', productId: '001'),
    ProductCategoryModel(categoryId: '6', productId: '001'),
    ProductCategoryModel(categoryId: '6', productId: '005'),
    ProductCategoryModel(categoryId: '6', productId: '009'),
    ProductCategoryModel(categoryId: '7', productId: '002'),
    ProductCategoryModel(categoryId: '17', productId: '003'),
    ProductCategoryModel(categoryId: '17', productId: '004'),
  ];

  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: TImages.productImage1,
      description: 'Green Nike sports shoe',
      brand: BrandModel(
          id: '1',
          name: 'Nike',
          image: TImages.nikeLogo,
          productsCount: 265,
          isFeatured: true),
      images: [
        TImages.productImage1,
        TImages.productImage23,
        TImages.productImage21,
        TImages.productImage9
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage1,
          description:
              'This is a Product description for Green Nike Sports shoe',
          attributeValues: {'Color': 'Green', "Size": 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 133,
          image: TImages.productImage23,
          attributeValues: {'Color': 'Black', "Size": 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 0,
          price: 234,
          image: TImages.productImage23,
          attributeValues: {'Color': 'Black', "Size": 'EU 34'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: TImages.productImage1,
          attributeValues: {'Color': 'Green', "Size": 'EU 32'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: TImages.productImage21,
          attributeValues: {'Color': 'Red', "Size": 'EU 34'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: TImages.productImage21,
          attributeValues: {'Color': 'Red', "Size": 'EU 32'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: TImages.productImage69,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
      images: [
        TImages.productImage68,
        TImages.productImage69,
        TImages.productImage5
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbnail: TImages.productImage64,
      description:
          'This is a Product description for Leather Brown Jacket. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
      images: [
        TImages.productImage64,
        TImages.productImage65,
        TImages.productImage66,
        TImages.productImage67
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '004',
      title: '4 Color collar t-shirt dry fit',
      stock: 15,
      price: 135,
      isFeatured: false,
      thumbnail: TImages.productImage60,
      description:
          'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
      images: [
        TImages.productImage60,
        TImages.productImage61,
        TImages.productImage62,
        TImages.productImage63
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage60,
          description: 'This is a Product for 4 Color collar t-shirt dry fit',
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 132,
            image: TImages.productImage60,
            attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '3',
            stock: 0,
            price: 234,
            image: TImages.productImage61,
            attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '4',
            stock: 222,
            price: 232,
            image: TImages.productImage61,
            attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '5',
            stock: 0,
            price: 334,
            image: TImages.productImage62,
            attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '6',
            stock: 11,
            price: 332,
            image: TImages.productImage62,
            attributeValues: {'Color': 'Green', 'Size': 'EU 30'}),
        ProductVariationModel(
            id: '7',
            stock: 0,
            price: 334,
            image: TImages.productImage63,
            attributeValues: {'Color': 'Blue', 'Size': 'EU 30'}),
        ProductVariationModel(
            id: '8',
            stock: 11,
            price: 332,
            image: TImages.productImage63,
            attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '005',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 35,
      isFeatured: false,
      thumbnail: TImages.productImage10,
      description:
          'This is a Product description for Nike Air Jordon Shoes. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(
          id: '1',
          name: 'Nike',
          image: TImages.nikeLogo,
          productsCount: 265,
          isFeatured: true),
      images: [
        TImages.productImage7,
        TImages.productImage8,
        TImages.productImage9,
        TImages.productImage10
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Orange', 'Black', 'Brown']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 36,
          salePrice: 12.6,
          image: TImages.productImage8,
          description:
              'Flutter is Google`s mobile UI open source framework to build high-quality native (super fast) interfaces for IOS nd Android apps with the unified code',
          attributeValues: {'Color': 'Orange', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 35,
            image: TImages.productImage7,
            attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '3',
            stock: 14,
            price: 34,
            image: TImages.productImage9,
            attributeValues: {'Color': 'Brown', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '4',
            stock: 13,
            price: 33,
            image: TImages.productImage7,
            attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '5',
            stock: 12,
            price: 32,
            image: TImages.productImage9,
            attributeValues: {'Color': 'Brown', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '6',
            stock: 11,
            price: 31,
            image: TImages.productImage8,
            attributeValues: {'Color': 'Orange', 'Size': 'EU 32'}),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '006',
      title: 'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM)',
      stock: 15,
      price: 750,
      isFeatured: false,
      thumbnail: TImages.productImage11,
      description:
          'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM), Long Battery timing',
      brand: BrandModel(id: '7', name: 'SAMSUNG', image: TImages.appleLogo),
      images: [
        TImages.productImage11,
        TImages.productImage12,
        TImages.productImage13,
        TImages.productImage12
      ],
      salePrice: 650,
      sku: 'ABR4568',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '007',
      title: 'TOMI Dog food',
      stock: 15,
      price: 20,
      isFeatured: false,
      thumbnail: TImages.productImage18,
      description:
          'This is a Product description for TOMI Dog food. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(id: '7', name: 'Tomi', image: TImages.appleLogo),
      salePrice: 10,
      sku: 'ABR4568',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '009',
      title: 'Nike Air Jorden 19 Blue',
      stock: 15,
      price: 400,
      isFeatured: false,
      thumbnail: TImages.productImage19,
      description:
          'This is a Product description for Nike Air Jorden 19 Blue. There are more things that can be added but i am practicing and nothing else.',
      brand: BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo),
      salePrice: 200,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
  ];
}
