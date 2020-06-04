package com.cen.appsite.shopcar.utill;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import com.cen.product.entity.Product;

public class AppUtill {
	public static List<Product> removeDuplicate(List<Product> list) {
		List<Product> listTemp = new ArrayList<Product>(); 
		List<String> list2 = new ArrayList<>();
        for(int i=0;i<list.size();i++){  
            if(!list2.contains(list.get(i).getId())){  
                listTemp.add(list.get(i));  
                list2.add(list.get(i).getId());
            }  
        }  
        return listTemp;  
	}
}
