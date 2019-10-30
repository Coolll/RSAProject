package com.wql.utils.security;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class AESHelper {

    private static final String keyString = "12345678876543211234567887654321";
    private static final String ivString = "8888777766665544";
    private static final String charset = "UTF-8";

    public static String encryptString(String content){
        try {
            byte[] contentBytes = content.getBytes(charset);
            byte[] keyBytes = keyString.getBytes(charset);

            byte[] encryptData = cipherAction(contentBytes,keyBytes,Cipher.ENCRYPT_MODE);

            byte[] base64Bytes = Base64.getEncoder().encode(encryptData);
            return new String(base64Bytes,charset);

        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public static String decryptString(String encryptString){
        try {
            byte[] decryptBytes = Base64.getDecoder().decode(encryptString);
            byte[] keyBytes = keyString.getBytes(charset);

            byte[] decryptData = cipherAction(decryptBytes,keyBytes,Cipher.DECRYPT_MODE);
            return new String(decryptData,charset);

        }catch (Exception e){
            e.printStackTrace();
        }
        return "";

    }


    private static byte[] cipherAction(byte[] contentBytes, byte[] keyBytes, int mode) {
        try {
            SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "AES");
            byte[] initParam = ivString.getBytes(charset);
            IvParameterSpec ivParameterSpec = new IvParameterSpec(initParam);

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(mode, secretKey, ivParameterSpec);

            return cipher.doFinal(contentBytes);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        String enString = AESHelper.encryptString("王啟龙");
        String deString = AESHelper.decryptString(enString);

        System.out.println("加密后："+enString+"\n解密后："+deString);
    }

}
