// pages/_document.js
import Document, { Html, Head, Main, NextScript } from "next/document";

class MyDocument extends Document {
  render() {
    const GA_ID = process.env.NEXT_PUBLIC_GA_ID || "";
    return (
      <Html lang="en">
        <Head>
          {GA_ID ? (
            <>
              <script async src={`https://www.googletagmanager.com/gtag/js?id=${GA_ID}`} />
              <script
                dangerouslySetInnerHTML={{
                  __html: `
                  window.dataLayer = window.dataLayer || [];
                  function gtag(){dataLayer.push(arguments);}
                  gtag('js', new Date());
                  gtag('config', '${GA_ID}', { 
                    send_page_view: true,
                    anonymize_ip: true
                  });
                `
                }}
              />
            </>
          ) : null}
          {/* Security headers configured in vercel.json */}
        </Head>
        <body>
          <Main />
          <NextScript />
        </body>
      </Html>
    );
  }
}

export default MyDocument;

